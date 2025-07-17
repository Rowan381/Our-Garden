import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'order_item_model.dart';
export 'order_item_model.dart';

class OrderItemWidget extends StatefulWidget {
  const OrderItemWidget({
    super.key,
    required this.seller,
    required this.orderItems,
    required this.orderRef,
    required this.buyerPaid,
  });

  final DocumentReference? seller;
  final List<OrderItemsStruct>? orderItems;
  final DocumentReference? orderRef;
  final bool? buyerPaid;

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  late OrderItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OrderItemModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((widget.seller == currentUserReference) && !widget.buyerPaid!) {
        _model.currOrder =
            await OrdersRecord.getDocumentOnce(widget.orderRef!);
        if (!(_model.currOrder?.stripeSessionID != null &&
            _model.currOrder?.stripeSessionID != '')) {
          return;
        }
        _model.retrievedSessionLoad =
            await StripeGroup.retrieveSessionCall.call(
          sessionID: _model.currOrder?.stripeSessionID,
        );

        if (StripeGroup.retrieveSessionCall.paymentStatus(
              (_model.retrievedSessionLoad?.jsonBody ?? ''),
            ) ==
            'paid') {
          await _model.currOrder!.reference.update(createOrdersRecordData(
            buyerPaid: true,
          ));
          _model.pendingOrderChat = await queryChatsRecordOnce(
            queryBuilder: (chatsRecord) => chatsRecord
                .where(
                  'user_a',
                  isEqualTo: _model.currOrder?.buyer,
                )
                .where(
                  'user_b',
                  isEqualTo: currentUserReference,
                ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          triggerPushNotification(
            notificationTitle:
                '${currentUserDisplayName} just paid you for their order!',
            notificationText: 'Tap to coordinate a pick-up',
            notificationImageUrl: currentUserPhoto,
            scheduledTime: dateTimeFromSecondsSinceEpoch(
                1800 + getCurrentTimestamp.secondsSinceEpoch),
            notificationSound: 'default',
            userRefs: [currentUserReference!],
            initialPageName: 'chat_2_Details_Cart',
            parameterData: {
              'chatDoc': _model.pendingOrderChat,
            },
          );
          return;
        }
      } else {
        return;
      }
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OrdersRecord>(
      stream: OrdersRecord.getDocument(widget.orderRef!),
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

        final containerOrdersRecord = snapshot.data!;

        return Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(36.0),
            border: Border.all(
              color: FlutterFlowTheme.of(context).primaryText,
              width: 1.0,
            ),
          ),
          child: StreamBuilder<UsersRecord>(
            stream: UsersRecord.getDocument(
                containerOrdersRecord.buyer == currentUserReference
                    ? containerOrdersRecord.seller!
                    : containerOrdersRecord.buyer!),
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

              final columnUsersRecord = snapshot.data!;

              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Align(
                          alignment: AlignmentDirectional(1.0, 0.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.45,
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 50.0,
                                    height: 50.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      columnUsersRecord.photoUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 15.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderRadius: 8.0,
                                              buttonSize: 40.0,
                                              icon: Icon(
                                                Icons.report,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                size: 24.0,
                                              ),
                                              onPressed: () async {
                                                var confirmDialogResponse =
                                                    await showDialog<bool>(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Report Order'),
                                                              content: Text(
                                                                  'Something look off? We want to know.'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext,
                                                                          false),
                                                                  child: Text(
                                                                      'Cancel'),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext,
                                                                          true),
                                                                  child: Text(
                                                                      'Raise Issue'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ) ??
                                                        false;
                                                if (confirmDialogResponse) {
                                                  if (currentUserReference ==
                                                      containerOrdersRecord
                                                          .buyer) {
                                                    _model.sellerDoc =
                                                        await UsersRecord
                                                            .getDocumentOnce(
                                                                containerOrdersRecord
                                                                    .seller!);
                                                    await launchUrl(Uri(
                                                        scheme: 'mailto',
                                                        path:
                                                            'society@plantculturecorp.com',
                                                        query: {
                                                          'subject':
                                                              'Reported Order',
                                                          'body':
                                                              'Reported by buyer Order reference: ${widget.orderRef?.id} buyer reference: ${containerOrdersRecord.buyer?.id} buyer email: ${currentUserEmail} seller reference: ${widget.seller?.id} seller email: ${_model.sellerDoc?.email}',
                                                        }
                                                            .entries
                                                            .map((MapEntry<
                                                                        String,
                                                                        String>
                                                                    e) =>
                                                                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                                            .join('&')));
                                                  } else {
                                                    _model.buyerDoc =
                                                        await UsersRecord
                                                            .getDocumentOnce(
                                                                containerOrdersRecord
                                                                    .buyer!);
                                                    await launchUrl(Uri(
                                                        scheme: 'mailto',
                                                        path:
                                                            'society@plantculturecorp.com',
                                                        query: {
                                                          'subject':
                                                              'Reported Order',
                                                          'body':
                                                              'Reported by seller Order reference: ${widget.orderRef?.id} buyer reference: ${containerOrdersRecord.buyer?.id} buyer email: ${_model.buyerDoc?.email} seller reference: ${widget.seller?.id} seller email: ${currentUserEmail}',
                                                        }
                                                            .entries
                                                            .map((MapEntry<
                                                                        String,
                                                                        String>
                                                                    e) =>
                                                                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                                            .join('&')));
                                                  }
                                                }

                                                safeSetState(() {});
                                              },
                                            ),
                                          ),
                                          Flexible(
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 5.0, 0.0, 0.0),
                                                child: Text(
                                                  columnUsersRecord.displayName,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts
                                                            .ibmPlexMono(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 5.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  children: [
                                    if (containerOrdersRecord.fulfillImage !=
                                            '')
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 5.0, 0.0, 0.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              valueOrDefault<String>(
                                                containerOrdersRecord
                                                    .fulfillImage,
                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/krb97ghfkdfv/applogostransparent2-24.png',
                                              ),
                                              width: 100.0,
                                              height: 100.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if ((containerOrdersRecord
                                                    .fulfillImage ==
                                                '') &&
                                        (containerOrdersRecord.seller ==
                                            currentUserReference))
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 25.0, 0.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              final selectedMedia =
                                                  await selectMediaWithSourceBottomSheet(
                                                context: context,
                                                allowPhoto: true,
                                              );
                                              if (selectedMedia != null &&
                                                  selectedMedia.every((m) =>
                                                      validateFileFormat(
                                                          m.storagePath,
                                                          context))) {
                                                safeSetState(() => _model
                                                        .isDataUploading_dropOffPic =
                                                    true);
                                                var selectedUploadedFiles =
                                                    <FFUploadedFile>[];

                                                var downloadUrls = <String>[];
                                                try {
                                                  selectedUploadedFiles =
                                                      selectedMedia
                                                          .map((m) =>
                                                              FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                                height: m
                                                                    .dimensions
                                                                    ?.height,
                                                                width: m
                                                                    .dimensions
                                                                    ?.width,
                                                                blurHash:
                                                                    m.blurHash,
                                                              ))
                                                          .toList();

                                                  downloadUrls =
                                                      (await Future.wait(
                                                    selectedMedia.map(
                                                      (m) async =>
                                                          await uploadData(
                                                              m.storagePath,
                                                              m.bytes),
                                                    ),
                                                  ))
                                                          .where(
                                                              (u) => u != null)
                                                          .map((u) => u!)
                                                          .toList();
                                                } finally {
                                                  _model.isDataUploading_dropOffPic =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                            .length ==
                                                        selectedMedia.length &&
                                                    downloadUrls.length ==
                                                        selectedMedia.length) {
                                                  safeSetState(() {
                                                    _model.uploadedLocalFile_dropOffPic =
                                                        selectedUploadedFiles
                                                            .first;
                                                    _model.uploadedFileUrl_dropOffPic =
                                                        downloadUrls.first;
                                                  });
                                                } else {
                                                  safeSetState(() {});
                                                  return;
                                                }
                                              }

                                              if (_model.uploadedFileUrl_dropOffPic !=
                                                      '') {
                                                await widget.orderRef!.update(
                                                    createOrdersRecordData(
                                                  fulfillImage: _model
                                                      .uploadedFileUrl_dropOffPic,
                                                ));
                                                triggerPushNotification(
                                                  notificationTitle:
                                                      '${currentUserDisplayName} dropped off your order',
                                                  notificationText:
                                                      'Enjoy your fresh, homegrown produce!',
                                                  notificationImageUrl: _model
                                                      .uploadedFileUrl_dropOffPic,
                                                  notificationSound: 'default',
                                                  userRefs: [
                                                    containerOrdersRecord.buyer!
                                                  ],
                                                  initialPageName: 'BasketPage',
                                                  parameterData: {
                                                    'ordersTab': true,
                                                  },
                                                );
                                              }
                                            },
                                            child: Container(
                                              width: 130.0,
                                              height: 60.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          1.0, 1.0, 1.0, 1.0),
                                                  child: Text(
                                                    'Upload Drop-Off Image',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          fontSize: 17.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 5.0, 0.0, 0.0),
                                          child: Text(
                                            'Status: ${containerOrdersRecord.buyerPaid == true ? 'paid' : 'unpaid'}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.ibmPlexMono(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
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
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 300.0,
                    child: Divider(
                      thickness: 2.0,
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                  ),
                  Container(
                    width: 320.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Builder(
                      builder: (context) {
                        final items = widget.orderItems!
                            .sortedList(keyOf: (e) => e.totalPrice, desc: false)
                            .toList();

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: items.length,
                          itemBuilder: (context, itemsIndex) {
                            final itemsItem = items[itemsIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 10.0),
                              child: Container(
                                height: 100.0,
                                constraints: BoxConstraints(
                                  maxWidth: 100.0,
                                ),
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 5.0, 0.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          valueOrDefault<String>(
                                            itemsItem.image,
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/krb97ghfkdfv/applogostransparent2-24.png',
                                          ),
                                          width: 75.0,
                                          height: 75.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 222.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 212.0,
                                            height: 48.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Flexible(
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            -1.0, 0.0),
                                                    child: Text(
                                                      itemsItem.productName,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .ibmPlexMono(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 15.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 5.0, 0.0),
                                              child: Text(
                                                '\$${itemsItem.totalPrice.toString()} (total)',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .ibmPlexMono(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
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
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                    child: Text(
                      'Total: \$${containerOrdersRecord.totalPrice.toString()}',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.ibmPlexMono(
                              fontWeight: FontWeight.w800,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 17.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w800,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
