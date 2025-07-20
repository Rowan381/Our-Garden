import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/chat_groupwbubbles/chat_details_overlay_listing/chat_details_overlay_listing_widget.dart';
import '/pages/chat_groupwbubbles/chat_thread_component/chat_thread_component_widget.dart';
import '/pages/marketplace/marketplace_assets/basket_item/basket_item_widget.dart';
import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat2_details_cart_model.dart';
export 'chat2_details_cart_model.dart';

class Chat2DetailsCartWidget extends StatefulWidget {
  const Chat2DetailsCartWidget({
    super.key,
    required this.chatDoc,
  });

  final ChatsRecord? chatDoc;

  static String routeName = 'chat_2_Details_Cart';
  static String routePath = '/chat2DetailsCart';

  @override
  State<Chat2DetailsCartWidget> createState() => _Chat2DetailsCartWidgetState();
}

class _Chat2DetailsCartWidgetState extends State<Chat2DetailsCartWidget> {
  late Chat2DetailsCartModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Chat2DetailsCartModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      unawaited(
        () async {
          await widget.chatDoc!.reference.update({
            ...mapToFirestore(
              {
                'last_message_seen_by':
                    FieldValue.arrayUnion([currentUserReference]),
              },
            ),
          });
        }(),
      );
      if (isAndroid) {
        _model.linkToApp =
            'https://play.google.com/store/apps/details?id=com.plantculture';
      }
      _model.chatMessageCount = await queryChatMessagesRecordCount(
        queryBuilder: (chatMessagesRecord) => chatMessagesRecord.where(
          'chat',
          isEqualTo: widget.chatDoc?.reference,
        ),
      );
      if ((widget.chatDoc?.userB == currentUserReference) &&
          (_model.chatMessageCount! <= 1)) {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('You\'ve got a Purchase Request!'),
              content: Text(
                  'See all the requested items by clicking the blue icon up top. Make sure all the items are in stock and good condition, coordinate pickup with the buyer, and approve the request!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
      }
      _model.pendingOrder = await queryOrdersRecordOnce(
        queryBuilder: (ordersRecord) => ordersRecord
            .where(
              'buyer',
              isEqualTo: currentUserReference,
            )
            .where(
              'buyerPaid',
              isEqualTo: false,
            ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (_model.pendingOrder != null) {
        _model.sellerAccountLoad =
            await UsersRecord.getDocumentOnce(_model.pendingOrder!.seller!);
        if (_model.pendingOrder?.stripeSessionID != null &&
            _model.pendingOrder?.stripeSessionID != '') {
          _model.retrievedSessionLoad =
              await StripeGroup.retrieveSessionCall.call(
            sessionID: _model.pendingOrder?.stripeSessionID,
          );

          if (StripeGroup.retrieveSessionCall.paymentStatus(
                (_model.retrievedSessionLoad?.jsonBody ?? ''),
              ) ==
              'paid') {
            await _model.pendingOrder!.reference.update(createOrdersRecordData(
              buyerPaid: true,
            ));
            _model.pendingOrderChat = await queryChatsRecordOnce(
              queryBuilder: (chatsRecord) => chatsRecord
                  .where(
                    'user_a',
                    isEqualTo: currentUserReference,
                  )
                  .where(
                    'user_b',
                    isEqualTo: _model.pendingOrder?.seller,
                  ),
              singleRecord: true,
            ).then((s) => s.firstOrNull);
            triggerPushNotification(
              notificationTitle:
                  '${currentUserDisplayName} just paid you for their order!',
              notificationText: 'Tap to coordinate a pick-up',
              notificationImageUrl: currentUserPhoto,
              notificationSound: 'default',
              userRefs: [_model.pendingOrder!.seller!],
              initialPageName: 'chat_2_Details_Cart',
              parameterData: {
                'chatDoc': _model.pendingOrderChat,
              },
            );
            return;
          }
        }
        var confirmDialogResponse = await showDialog<bool>(
              context: context,
              builder: (alertDialogContext) {
                return AlertDialog(
                  title: Text('The seller just approved your order!'),
                  content: Text('Press confirm to pay'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext, false),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext, true),
                      child: Text('Confirm'),
                    ),
                  ],
                );
              },
            ) ??
            false;
        if (confirmDialogResponse) {
          _model.paymentResult = await StripeGroup.sessionsCall.call(
            connectedAcct: _model.sellerAccountLoad?.stripeAccountID,
            cancelURL: _model.linkToApp,
            successURL: _model.linkToApp,
            currency: 'usd',
            productName: 'Homegrown Produce',
            pricePerUnit: (_model.pendingOrder!.totalPrice * 100).toInt(),
            quantity: 1,
            stripeFee: 30 +
                (0.034 * ((_model.pendingOrder!.totalPrice * 100).toInt()))
                    .toInt(),
          );

          if ((_model.paymentResult?.succeeded ?? true)) {
            await _model.pendingOrder!.reference.update(createOrdersRecordData(
              stripeSessionID: StripeGroup.sessionsCall.id(
                (_model.paymentResult?.jsonBody ?? ''),
              ),
            ));
            await launchURL(StripeGroup.sessionsCall.url(
              (_model.paymentResult?.jsonBody ?? ''),
            )!);
          } else {
            await launchURL(
                'editing://editing.com${GoRouterState.of(context).uri.toString()}');
            await showDialog(
              context: context,
              builder: (alertDialogContext) {
                return AlertDialog(
                  title: Text('Payment Didn\'t Go Through'),
                  content: Text('Please Try Again'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext),
                      child: Text('Ok'),
                    ),
                  ],
                );
              },
            );
            return;
          }
        } else {
          await launchURL(
              'editing://editing.com${GoRouterState.of(context).uri.toString()}');
        }
      } else {
        return;
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UsersRecord>(
      future: UsersRecord.getDocumentOnce(
          widget.chatDoc?.userA == currentUserReference
              ? widget.chatDoc!.userB!
              : widget.chatDoc!.userA!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final chat2DetailsCartUsersRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100.0),
                child: AppBar(
                  backgroundColor:
                      FlutterFlowTheme.of(context).primaryBackground,
                  automaticallyImplyLeading: false,
                  leading: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 60.0,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      context.safePop();
                    },
                  ),
                  title: StreamBuilder<PendingBasketRecord>(
                    stream: PendingBasketRecord.getDocument(
                        widget.chatDoc!.pendingBasket!),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }

                      final columnPendingBasketRecord = snapshot.data!;

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          StreamBuilder<ProductRecord>(
                            stream: ProductRecord.getDocument(
                                columnPendingBasketRecord
                                    .basketItems.firstOrNull!.productRef!),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              final rowSingleUserProductRecord = snapshot.data!;

                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (widget.chatDoc!.hasProductRef()) {
                                    _model.newProductRef =
                                        await ProductRecord.getDocumentOnce(
                                            widget.chatDoc!.productRef!);
                                  }

                                  safeSetState(() {});
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, -1.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 12.0, 0.0),
                                        child: Container(
                                          width: 70.0,
                                          height: 70.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                chat2DetailsCartUsersRecord
                                                    .photoUrl,
                                                width: 44.0,
                                                height: 44.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxHeight: 100.0,
                                        ),
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  4.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          chat2DetailsCartUsersRecord
                                                                      .email !=
                                                                  currentUserEmail
                                                              ? valueOrDefault<
                                                                  String>(
                                                                  chat2DetailsCartUsersRecord
                                                                      .displayName,
                                                                  'OurGarden User',
                                                                )
                                                              : rowSingleUserProductRecord
                                                                  .title,
                                                          'OurGarden User',
                                                        ),
                                                        maxLines: 3,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyLarge
                                                            .override(
                                                              font: GoogleFonts
                                                                  .inter(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                              ),
                                                              fontSize: 20.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  if (widget.chatDoc
                                                          ?.pendingBasket !=
                                                      null)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              1.0, 0.0),
                                                      child: Builder(
                                                        builder: (context) =>
                                                            InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (dialogContext) {
                                                                return Dialog(
                                                                  elevation: 0,
                                                                  insetPadding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  alignment: AlignmentDirectional(
                                                                          0.0,
                                                                          0.0)
                                                                      .resolve(
                                                                          Directionality.of(
                                                                              context)),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      FocusScope.of(
                                                                              dialogContext)
                                                                          .unfocus();
                                                                      FocusManager
                                                                          .instance
                                                                          .primaryFocus
                                                                          ?.unfocus();
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.85,
                                                                      child:
                                                                          BasketItemWidget(
                                                                        seller: widget
                                                                            .chatDoc!
                                                                            .userB!,
                                                                        basketItems:
                                                                            columnPendingBasketRecord.basketItems,
                                                                        pendingBasketRef:
                                                                            columnPendingBasketRecord.reference,
                                                                        pending:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          4.0),
                                                              child: Icon(
                                                                Icons
                                                                    .shopping_basket_rounded,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 35.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  actions: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 16.0, 8.0),
                      child: FlutterFlowIconButton(
                        borderColor: FlutterFlowTheme.of(context).alternate,
                        borderRadius: 12.0,
                        borderWidth: 2.0,
                        buttonSize: 40.0,
                        fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        icon: Icon(
                          Icons.more_vert,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor:
                                FlutterFlowTheme.of(context).accent4,
                            barrierColor: Color(0x00FFFFFF),
                            context: context,
                            builder: (context) {
                              return GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: ChatDetailsOverlayListingWidget(
                                    chatRef: widget.chatDoc!,
                                  ),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                      ),
                    ),
                  ],
                  centerTitle: false,
                  toolbarHeight: 100.0,
                  elevation: 2.0,
                ),
              ),
              body: SafeArea(
                top: true,
                child: wrapWithModel(
                  model: _model.chatThreadComponentModel,
                  updateCallback: () => safeSetState(() {}),
                  updateOnChange: true,
                  child: ChatThreadComponentWidget(
                    chatDoc: widget.chatDoc,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
