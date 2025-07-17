import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/tour_home_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/marketplace/marketplace_assets/empty_list_message/empty_list_message_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({
    super.key,
    bool? onTour,
  }) : this.onTour = onTour ?? false;

  final bool onTour;

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.ffIsVeryStupid = await queryOrdersRecordCount(
        queryBuilder: (ordersRecord) => ordersRecord
            .where(
              'buyer',
              isEqualTo: currentUserReference,
            )
            .where(
              'buyerPaid',
              isEqualTo: false,
            ),
      );
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
      if (_model.ffIsVeryStupid! >= 1) {
        _model.sellerAccountLoad =
            await UsersRecord.getDocumentOnce(_model.pendingOrder!.seller!);
        if (_model.pendingOrder?.stripeSessionID != null &&
            _model.pendingOrder?.stripeSessionID != '') {
          _model.retrievedSessionLoad =
              await StripeGroup.retrieveSessionCall.call(
            sessionID: _model.sellerAccountLoad?.stripeAccountID,
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
                  title: Text('Something Went Wrong'),
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

      if (isAndroid) {
        _model.linkToApp =
            'https://play.google.com/store/apps/details?id=com.plantculture';
      }
      _model.userDoc = await queryUsersRecordOnce(
        queryBuilder: (usersRecord) => usersRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      if (_model.userDoc!.firstSignIn) {
        await showDialog(
          barrierColor: Color(0x34000000),
          barrierDismissible: false,
          context: context,
          builder: (dialogContext) {
            return Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              alignment: AlignmentDirectional(0.0, 0.0)
                  .resolve(Directionality.of(context)),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(dialogContext).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: TourHomeWidget(),
              ),
            );
          },
        );

        await _model.userDoc!.reference.update(createUsersRecordData(
          firstSignIn: false,
        ));
      } else if (widget.onTour) {
        await showDialog(
          barrierColor: Color(0x34000000),
          barrierDismissible: false,
          context: context,
          builder: (dialogContext) {
            return Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              alignment: AlignmentDirectional(0.0, 0.0)
                  .resolve(Directionality.of(context)),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(dialogContext).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: TourHomeWidget(),
              ),
            );
          },
        );

        await _model.userDoc!.reference.update(createUsersRecordData(
          firstSignIn: false,
        ));
      }

      _model.userGardenTasks = await queryGardenTasksRecordOnce(
        queryBuilder: (gardenTasksRecord) => gardenTasksRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
      );
      _model.userPlantTasks = await queryPlantTasksRecordOnce(
        queryBuilder: (plantTasksRecord) => plantTasksRecord.where(
          'userCreatorID',
          isEqualTo: currentUserUid,
        ),
      );
      if (!functions.compareDates(
          FFAppState().lastTaskResetDate!,
          DateTime.fromMicrosecondsSinceEpoch(
              getCurrentTimestamp.secondsSinceEpoch))) {
        _model.updateCompleteGarden = await queryGardenTasksRecordOnce(
          queryBuilder: (gardenTasksRecord) => gardenTasksRecord.where(
            'completedToday',
            isEqualTo: true,
          ),
        );
        _model.lenGardensToUpdate = _model.updateCompleteGarden!.length;
        safeSetState(() {});
        while (_model.lenGardensToUpdate >= 0) {
          await _model.updateCompleteGarden!
              .elementAtOrNull(_model.lenGardensToUpdate)!
              .reference
              .update(createGardenTasksRecordData(
                completedToday: false,
              ));
          _model.lenGardensToUpdate = _model.lenGardensToUpdate + -1;
          safeSetState(() {});
        }
        _model.updateCompletePlant = await queryPlantTasksRecordOnce(
          queryBuilder: (plantTasksRecord) => plantTasksRecord.where(
            'completedToday',
            isEqualTo: true,
          ),
        );
        _model.lenPlantsToUpdate = _model.userPlantTasks!.length;
        safeSetState(() {});
        while (_model.lenPlantsToUpdate >= 0) {
          await _model.updateCompleteGarden!
              .elementAtOrNull(_model.lenGardensToUpdate)!
              .reference
              .update(createGardenTasksRecordData(
                completedToday: false,
              ));
          _model.lenPlantsToUpdate = _model.lenPlantsToUpdate + -1;
          safeSetState(() {});
        }
        FFAppState().lastTaskResetDate = getCurrentTimestamp;
        safeSetState(() {});
      }
      await showDialog(
        context: context,
        builder: (dialogContext) {
          return Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            alignment: AlignmentDirectional(0.0, 0.0)
                .resolve(Directionality.of(context)),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(dialogContext).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: TourHomeWidget(),
            ),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) => StreamBuilder<List<ProductRecord>>(
        stream: queryProductRecord(
          queryBuilder: (productRecord) => productRecord
              .where(
                'seller',
                isNotEqualTo: currentUserReference,
              )
              .where(
                'isArchived',
                isEqualTo: false,
              ),
          limit: 100,
        ),
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
          List<ProductRecord> homePageProductRecordList = snapshot.data!;

          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
                body: SafeArea(
                  top: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.88,
                            decoration: BoxDecoration(),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment:
                                        AlignmentDirectional(-0.03, -0.99),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 15.0, 0.0, 10.0),
                                      child: Container(
                                        width: 350.0,
                                        height: 75.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(50.0),
                                            bottomRight: Radius.circular(50.0),
                                            topLeft: Radius.circular(50.0),
                                            topRight: Radius.circular(50.0),
                                          ),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Builder(
                                                builder: (context) {
                                                  if (currentUserDocument
                                                          ?.location !=
                                                      null) {
                                                    return Stack(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child:
                                                              FlutterFlowIconButton(
                                                            borderRadius: 20.0,
                                                            borderWidth: 1.0,
                                                            buttonSize: 60.0,
                                                            icon: Icon(
                                                              Icons
                                                                  .location_on_outlined,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              size: 40.0,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              var confirmDialogResponse =
                                                                  await showDialog<
                                                                          bool>(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (alertDialogContext) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('Update Location Services'),
                                                                            content:
                                                                                Text('Would you like to update your current location?'),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                child: Text('Not Now'),
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
                                                                context.pushNamed(
                                                                    LocationServicesWidget
                                                                        .routeName);
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Container(
                                                            width: 240.0,
                                                            height: 85.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Align(
                                                                      alignment: AlignmentDirectional(
                                                                          -0.01,
                                                                          0.42),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault(
                                                                            currentUserDocument?.city,
                                                                            ''),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 25.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  } else {
                                                    return Stack(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child:
                                                              FlutterFlowIconButton(
                                                            borderRadius: 20.0,
                                                            borderWidth: 1.0,
                                                            buttonSize: 60.0,
                                                            icon: Icon(
                                                              Icons
                                                                  .location_off_outlined,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              size: 35.0,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              var confirmDialogResponse =
                                                                  await showDialog<
                                                                          bool>(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (alertDialogContext) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('Location Services'),
                                                                            content:
                                                                                Text('In order to search nearby, this app requires access to your current location.'),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                child: Text('Not Now'),
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
                                                                context.pushNamed(
                                                                    LocationServicesWidget
                                                                        .routeName);
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Container(
                                                            width: 240.0,
                                                            height: 100.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            6.0),
                                                                        child:
                                                                            Text(
                                                                          'Location Not Enabled',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 22.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              child: FlutterFlowIconButton(
                                                borderRadius: 20.0,
                                                borderWidth: 1.0,
                                                buttonSize: 60.0,
                                                icon: Icon(
                                                  Icons.settings_outlined,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  size: 40.0,
                                                ),
                                                onPressed: () async {
                                                  await launchURL(
                                                      'https://www.google.com');

                                                  context.pushNamed(
                                                      AccountSettingsWidget
                                                          .routeName);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, -0.62),
                                    child: Container(
                                      width: 359.0,
                                      height: 140.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 4.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 1.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                        GptWidget.routeName);
                                                  },
                                                  child: Container(
                                                    width: 165.0,
                                                    height: 125.0,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF57A773),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFF57A773),
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          FFIcons.ksagelogo,
                                                          color: Colors.white,
                                                          size: 60.0,
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, -1.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        5.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              'Ask Sage',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        24.0,
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
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        1.0, 0.0, 0.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                        Chat2MainNewWidget
                                                            .routeName);
                                                  },
                                                  child: Container(
                                                    width: 165.0,
                                                    height: 125.0,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF157145),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFF157145),
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      2.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Icon(
                                                            Icons
                                                                .chat_bubble_outline_rounded,
                                                            color: Colors.white,
                                                            size: 70.0,
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, -1.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        5.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              'Messages',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        24.0,
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
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 20.0),
                                      child: Container(
                                        width: 350.0,
                                        height: 455.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                      MarketplaceExploreListingsWidget
                                                          .routeName);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 11.0,
                                                                0.0, 5.0),
                                                    child: Text(
                                                      'OurMarket Produce For You',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 24.0,
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
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Container(
                                                decoration: BoxDecoration(),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Builder(
                                                      builder: (context) {
                                                        if (currentUserDocument
                                                                ?.location !=
                                                            null) {
                                                          return Container(
                                                            height: 360.0,
                                                            constraints:
                                                                BoxConstraints(
                                                              maxHeight: 415.0,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Builder(
                                                              builder:
                                                                  (context) {
                                                                final filterByLocation =
                                                                    (functions.getProductsDistance(homePageProductRecordList.toList(), 1000.0, currentUserDocument?.location)?.toList() ??
                                                                            [])
                                                                        .take(3)
                                                                        .toList();
                                                                if (filterByLocation
                                                                    .isEmpty) {
                                                                  return Center(
                                                                    child:
                                                                        EmptyListMessageWidget(
                                                                      message1:
                                                                          'No Listings For Sale Near Your Current Location',
                                                                      message2:
                                                                          'Please check for more listings at a later time!',
                                                                    ),
                                                                  );
                                                                }

                                                                return Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: List.generate(
                                                                      filterByLocation
                                                                          .length,
                                                                      (filterByLocationIndex) {
                                                                    final filterByLocationItem =
                                                                        filterByLocation[
                                                                            filterByLocationIndex];
                                                                    return Container(
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                103.5,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  context.pushNamed(
                                                                                    ListingDetailsWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'listingtoPost': serializeParam(
                                                                                        filterByLocationItem.reference,
                                                                                        ParamType.DocumentReference,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                  );
                                                                                },
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                                                                        child: Container(
                                                                                          width: 90.0,
                                                                                          height: 90.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          ),
                                                                                          child: ClipRRect(
                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                            child: Image.network(
                                                                                              filterByLocationItem.image == '' ? 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/krb97ghfkdfv/applogostransparent2-24.png' : filterByLocationItem.image,
                                                                                              width: 196.0,
                                                                                              height: 200.0,
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                      child: Container(
                                                                                        width: 185.0,
                                                                                        height: 100.0,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 175.0,
                                                                                                    height: 42.0,
                                                                                                    decoration: BoxDecoration(),
                                                                                                    child: Align(
                                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                      child: SingleChildScrollView(
                                                                                                        child: Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            AutoSizeText(
                                                                                                              '\$${valueOrDefault<String>(
                                                                                                                functions.displayValidPrice(filterByLocationItem.price),
                                                                                                                '0.00',
                                                                                                              )} - ${valueOrDefault<String>(
                                                                                                                filterByLocationItem.title,
                                                                                                                'New Listing',
                                                                                                              )}',
                                                                                                              textAlign: TextAlign.center,
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.inter(
                                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 18.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Container(
                                                                                                    width: 175.0,
                                                                                                    height: 30.0,
                                                                                                    decoration: BoxDecoration(),
                                                                                                    child: Align(
                                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                      child: SingleChildScrollView(
                                                                                                        child: Column(
                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                          children: [
                                                                                                            Opacity(
                                                                                                              opacity: 0.4,
                                                                                                              child: Text(
                                                                                                                '${valueOrDefault<String>(
                                                                                                                  filterByLocationItem.units.toString(),
                                                                                                                  '0',
                                                                                                                )} ${valueOrDefault<String>(
                                                                                                                  filterByLocationItem.units != 1
                                                                                                                      ? valueOrDefault<String>(
                                                                                                                          '${valueOrDefault<String>(
                                                                                                                            filterByLocationItem.unitType,
                                                                                                                            'pound',
                                                                                                                          )}s ',
                                                                                                                          'pounds ',
                                                                                                                        )
                                                                                                                      : valueOrDefault<String>(
                                                                                                                          '${valueOrDefault<String>(
                                                                                                                            filterByLocationItem.unitType,
                                                                                                                            'pound',
                                                                                                                          )} ',
                                                                                                                          'pound ',
                                                                                                                        ),
                                                                                                                  'pound ',
                                                                                                                )}left',
                                                                                                                textAlign: TextAlign.center,
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.inter(
                                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: 16.0,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(0.0, -0.25),
                                                                                      child: InkWell(
                                                                                        splashColor: Colors.transparent,
                                                                                        focusColor: Colors.transparent,
                                                                                        hoverColor: Colors.transparent,
                                                                                        highlightColor: Colors.transparent,
                                                                                        onTap: () async {
                                                                                          _model.addToUsers(currentUserReference!);
                                                                                          safeSetState(() {});
                                                                                          _model.addToUsers(filterByLocationItem.seller!);
                                                                                          safeSetState(() {});
                                                                                          // newChat

                                                                                          var chatsRecordReference = ChatsRecord.collection.doc();
                                                                                          await chatsRecordReference.set({
                                                                                            ...createChatsRecordData(
                                                                                              userA: currentUserReference,
                                                                                              userB: filterByLocationItem.seller,
                                                                                              lastMessage: '',
                                                                                              lastMessageTime: getCurrentTimestamp,
                                                                                              lastMessageSentBy: currentUserReference,
                                                                                              groupChatId: random_data.randomInteger(1000000, 9999999),
                                                                                              productRef: filterByLocationItem.reference,
                                                                                              isListingMessage: true,
                                                                                              isEmptyChat: true,
                                                                                            ),
                                                                                            ...mapToFirestore(
                                                                                              {
                                                                                                'users': _model.users,
                                                                                              },
                                                                                            ),
                                                                                          });
                                                                                          _model.newListingChatThread2 = ChatsRecord.getDocumentFromData({
                                                                                            ...createChatsRecordData(
                                                                                              userA: currentUserReference,
                                                                                              userB: filterByLocationItem.seller,
                                                                                              lastMessage: '',
                                                                                              lastMessageTime: getCurrentTimestamp,
                                                                                              lastMessageSentBy: currentUserReference,
                                                                                              groupChatId: random_data.randomInteger(1000000, 9999999),
                                                                                              productRef: filterByLocationItem.reference,
                                                                                              isListingMessage: true,
                                                                                              isEmptyChat: true,
                                                                                            ),
                                                                                            ...mapToFirestore(
                                                                                              {
                                                                                                'users': _model.users,
                                                                                              },
                                                                                            ),
                                                                                          }, chatsRecordReference);

                                                                                          context.pushNamed(
                                                                                            Chat2DetailsListingWidget.routeName,
                                                                                            queryParameters: {
                                                                                              'chatRef': serializeParam(
                                                                                                _model.newListingChatThread2,
                                                                                                ParamType.Document,
                                                                                              ),
                                                                                            }.withoutNulls,
                                                                                            extra: <String, dynamic>{
                                                                                              'chatRef': _model.newListingChatThread2,
                                                                                            },
                                                                                          );

                                                                                          safeSetState(() {});
                                                                                        },
                                                                                        child: Icon(
                                                                                          Icons.add_comment_outlined,
                                                                                          color: FlutterFlowTheme.of(context).secondary,
                                                                                          size: 30.0,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                2.0,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        } else {
                                                          return Container(
                                                            height: 360.0,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: StreamBuilder<
                                                                List<
                                                                    ProductRecord>>(
                                                              stream:
                                                                  queryProductRecord(
                                                                queryBuilder:
                                                                    (productRecord) =>
                                                                        productRecord
                                                                            .where(
                                                                              'seller',
                                                                              isNotEqualTo: currentUserReference,
                                                                            )
                                                                            .where(
                                                                              'isArchived',
                                                                              isEqualTo: false,
                                                                            ),
                                                                limit: 3,
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<ProductRecord>
                                                                    columnProductRecordList =
                                                                    snapshot
                                                                        .data!;
                                                                if (columnProductRecordList
                                                                    .isEmpty) {
                                                                  return Center(
                                                                    child:
                                                                        EmptyListMessageWidget(
                                                                      message1:
                                                                          'No Listings Currently For Sale',
                                                                      message2:
                                                                          'Please check for more listings at a later time!',
                                                                    ),
                                                                  );
                                                                }

                                                                return Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: List.generate(
                                                                      columnProductRecordList
                                                                          .length,
                                                                      (columnIndex) {
                                                                    final columnProductRecord =
                                                                        columnProductRecordList[
                                                                            columnIndex];
                                                                    return Container(
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                103.5,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  context.pushNamed(
                                                                                    ListingDetailsWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'listingtoPost': serializeParam(
                                                                                        columnProductRecord.reference,
                                                                                        ParamType.DocumentReference,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                  );
                                                                                },
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                                                                        child: Container(
                                                                                          width: 90.0,
                                                                                          height: 90.0,
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          ),
                                                                                          child: ClipRRect(
                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                            child: Image.network(
                                                                                              columnProductRecord.image == '' ? 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/krb97ghfkdfv/applogostransparent2-24.png' : columnProductRecord.image,
                                                                                              width: 196.0,
                                                                                              height: 200.0,
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      width: 185.0,
                                                                                      height: 100.0,
                                                                                      decoration: BoxDecoration(),
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                child: Container(
                                                                                                  width: 175.0,
                                                                                                  height: 42.0,
                                                                                                  decoration: BoxDecoration(),
                                                                                                  child: Align(
                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                    child: SingleChildScrollView(
                                                                                                      child: Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            '\$${valueOrDefault<String>(
                                                                                                              functions.displayValidPrice(columnProductRecord.price),
                                                                                                              '0.00',
                                                                                                            )} - ${valueOrDefault<String>(
                                                                                                              columnProductRecord.title,
                                                                                                              'New Listing',
                                                                                                            )}',
                                                                                                            textAlign: TextAlign.center,
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.inter(
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  fontSize: 18.0,
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                child: Container(
                                                                                                  width: 175.0,
                                                                                                  height: 30.0,
                                                                                                  decoration: BoxDecoration(),
                                                                                                  child: Align(
                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                    child: SingleChildScrollView(
                                                                                                      child: Column(
                                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                                        children: [
                                                                                                          Opacity(
                                                                                                            opacity: 0.4,
                                                                                                            child: Text(
                                                                                                              '${valueOrDefault<String>(
                                                                                                                columnProductRecord.units.toString(),
                                                                                                                '0',
                                                                                                              )} ${valueOrDefault<String>(
                                                                                                                columnProductRecord.units != 1
                                                                                                                    ? valueOrDefault<String>(
                                                                                                                        '${valueOrDefault<String>(
                                                                                                                          columnProductRecord.unitType,
                                                                                                                          'pound',
                                                                                                                        )}s ',
                                                                                                                        'pounds ',
                                                                                                                      )
                                                                                                                    : valueOrDefault<String>(
                                                                                                                        '${valueOrDefault<String>(
                                                                                                                          columnProductRecord.unitType,
                                                                                                                          'pound',
                                                                                                                        )} ',
                                                                                                                        'pound ',
                                                                                                                      ),
                                                                                                                'pound ',
                                                                                                              )}left',
                                                                                                              textAlign: TextAlign.center,
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.inter(
                                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: 16.0,
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(0.0, -0.25),
                                                                                      child: InkWell(
                                                                                        splashColor: Colors.transparent,
                                                                                        focusColor: Colors.transparent,
                                                                                        hoverColor: Colors.transparent,
                                                                                        highlightColor: Colors.transparent,
                                                                                        onTap: () async {
                                                                                          _model.addToUsers(currentUserReference!);
                                                                                          safeSetState(() {});
                                                                                          _model.addToUsers(columnProductRecord.seller!);
                                                                                          safeSetState(() {});
                                                                                          // newChat

                                                                                          var chatsRecordReference = ChatsRecord.collection.doc();
                                                                                          await chatsRecordReference.set({
                                                                                            ...createChatsRecordData(
                                                                                              userA: currentUserReference,
                                                                                              userB: columnProductRecord.seller,
                                                                                              lastMessage: '',
                                                                                              lastMessageTime: getCurrentTimestamp,
                                                                                              lastMessageSentBy: currentUserReference,
                                                                                              groupChatId: random_data.randomInteger(1000000, 9999999),
                                                                                              productRef: columnProductRecord.reference,
                                                                                              isListingMessage: true,
                                                                                              isEmptyChat: true,
                                                                                            ),
                                                                                            ...mapToFirestore(
                                                                                              {
                                                                                                'users': _model.users,
                                                                                              },
                                                                                            ),
                                                                                          });
                                                                                          _model.newListingChatThread3 = ChatsRecord.getDocumentFromData({
                                                                                            ...createChatsRecordData(
                                                                                              userA: currentUserReference,
                                                                                              userB: columnProductRecord.seller,
                                                                                              lastMessage: '',
                                                                                              lastMessageTime: getCurrentTimestamp,
                                                                                              lastMessageSentBy: currentUserReference,
                                                                                              groupChatId: random_data.randomInteger(1000000, 9999999),
                                                                                              productRef: columnProductRecord.reference,
                                                                                              isListingMessage: true,
                                                                                              isEmptyChat: true,
                                                                                            ),
                                                                                            ...mapToFirestore(
                                                                                              {
                                                                                                'users': _model.users,
                                                                                              },
                                                                                            ),
                                                                                          }, chatsRecordReference);

                                                                                          context.pushNamed(
                                                                                            Chat2DetailsListingWidget.routeName,
                                                                                            queryParameters: {
                                                                                              'chatRef': serializeParam(
                                                                                                _model.newListingChatThread3,
                                                                                                ParamType.Document,
                                                                                              ),
                                                                                            }.withoutNulls,
                                                                                            extra: <String, dynamic>{
                                                                                              'chatRef': _model.newListingChatThread3,
                                                                                            },
                                                                                          );

                                                                                          safeSetState(() {});
                                                                                        },
                                                                                        child: Icon(
                                                                                          Icons.add_comment_outlined,
                                                                                          color: FlutterFlowTheme.of(context).secondary,
                                                                                          size: 30.0,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                2.0,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 1.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                      MarketplaceExploreListingsWidget
                                                          .routeName);
                                                },
                                                child: Container(
                                                  width: 350.0,
                                                  height: 43.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 10.0),
                                                    child: Text(
                                                      'View More',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 24.0,
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
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                              ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 10.0, 150.0),
                                    child: Container(
                                      width: 350.0,
                                      constraints: BoxConstraints(
                                        maxHeight: 300.0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Container(
                                              width: 360.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0.0),
                                                  bottomRight:
                                                      Radius.circular(0.0),
                                                  topLeft:
                                                      Radius.circular(24.0),
                                                  topRight:
                                                      Radius.circular(24.0),
                                                ),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  width: 2.0,
                                                ),
                                              ),
                                              alignment: AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 10.0, 0.0, 0.0),
                                                child: Text(
                                                  'Today\'s Tasks',
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
                                                        fontSize: 24.0,
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
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 360.0,
                                            constraints: BoxConstraints(
                                              maxHeight: 350.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .accent3,
                                            ),
                                            child: FutureBuilder<
                                                List<GardensRecord>>(
                                              future: queryGardensRecordOnce(
                                                queryBuilder: (gardensRecord) =>
                                                    gardensRecord.where(
                                                  'uid',
                                                  isEqualTo: currentUserUid,
                                                ),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                List<GardensRecord>
                                                    columnGardensRecordList =
                                                    snapshot.data!;

                                                return SingleChildScrollView(
                                                  primary: false,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: List.generate(
                                                        columnGardensRecordList
                                                            .length,
                                                        (columnIndex) {
                                                      final columnGardensRecord =
                                                          columnGardensRecordList[
                                                              columnIndex];
                                                      return Visibility(
                                                        visible: (_model
                                                                .userPlantTasks!
                                                                .where((e) =>
                                                                    (e.gardenCreatorRef ==
                                                                        columnGardensRecord
                                                                            .reference) &&
                                                                    functions.checkToday(
                                                                        e
                                                                            .startDate!,
                                                                        e
                                                                            .frequencyNum,
                                                                        e
                                                                            .frequencyType))
                                                                .toList()
                                                                .isNotEmpty) ||
                                                            (_model
                                                                .userGardenTasks!
                                                                .where((e) =>
                                                                    (e.gardenCreatorRef ==
                                                                        columnGardensRecord
                                                                            .reference) &&
                                                                    functions.checkToday(
                                                                        e.startDate!,
                                                                        e.frequencyNum,
                                                                        e.frequencyType))
                                                                .toList()
                                                                .isNotEmpty),
                                                        child: Flexible(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFD1F3FF),
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0x3100ADEA),
                                                                width: 2.0,
                                                              ),
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              30.0,
                                                                              15.0,
                                                                              0.0,
                                                                              15.0),
                                                                          child:
                                                                              Text(
                                                                            columnGardensRecord.gardenName.maybeHandleOverflow(
                                                                              maxChars: 15,
                                                                              replacement: '…',
                                                                            ),
                                                                            maxLines:
                                                                                1,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.ibmPlexMono(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  fontSize: 24.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              30.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              FlutterFlowIconButton(
                                                                            borderRadius:
                                                                                20.0,
                                                                            borderWidth:
                                                                                1.0,
                                                                            buttonSize:
                                                                                40.0,
                                                                            icon:
                                                                                Icon(
                                                                              Icons.arrow_forward_ios,
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              size: 24.0,
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              context.pushNamed(
                                                                                ViewGardenWidget.routeName,
                                                                                queryParameters: {
                                                                                  'gardenRef': serializeParam(
                                                                                    columnGardensRecord.reference,
                                                                                    ParamType.DocumentReference,
                                                                                  ),
                                                                                }.withoutNulls,
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: StreamBuilder<
                                                                        List<
                                                                            GardenTasksRecord>>(
                                                                      stream:
                                                                          queryGardenTasksRecord(
                                                                        queryBuilder: (gardenTasksRecord) => gardenTasksRecord
                                                                            .where(
                                                                              'uid',
                                                                              isEqualTo: columnGardensRecord.uid,
                                                                            )
                                                                            .where(
                                                                              'gardenCreatorRef',
                                                                              isEqualTo: columnGardensRecord.reference,
                                                                            ),
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                        List<GardenTasksRecord>
                                                                            todayTasksListGardenTasksRecordList =
                                                                            snapshot.data!;

                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: List.generate(
                                                                              todayTasksListGardenTasksRecordList.length,
                                                                              (todayTasksListIndex) {
                                                                            final todayTasksListGardenTasksRecord =
                                                                                todayTasksListGardenTasksRecordList[todayTasksListIndex];
                                                                            return Visibility(
                                                                              visible: functions.checkToday(todayTasksListGardenTasksRecord.startDate!, todayTasksListGardenTasksRecord.frequencyNum, todayTasksListGardenTasksRecord.frequencyType),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Theme(
                                                                                    data: ThemeData(
                                                                                      checkboxTheme: CheckboxThemeData(
                                                                                        visualDensity: VisualDensity.compact,
                                                                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(4.0),
                                                                                        ),
                                                                                      ),
                                                                                      unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                    ),
                                                                                    child: Checkbox(
                                                                                      value: _model.checkboxValueMap1[todayTasksListGardenTasksRecord] ??= todayTasksListGardenTasksRecord.completedToday,
                                                                                      onChanged: (newValue) async {
                                                                                        safeSetState(() => _model.checkboxValueMap1[todayTasksListGardenTasksRecord] = newValue!);
                                                                                        if (newValue!) {
                                                                                          await todayTasksListGardenTasksRecord.reference.update(createGardenTasksRecordData(
                                                                                            completedToday: true,
                                                                                          ));
                                                                                        } else {
                                                                                          await todayTasksListGardenTasksRecord.reference.update(createGardenTasksRecordData(
                                                                                            completedToday: false,
                                                                                          ));
                                                                                        }
                                                                                      },
                                                                                      side: (FlutterFlowTheme.of(context).secondaryText != null)
                                                                                          ? BorderSide(
                                                                                              width: 2,
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            )
                                                                                          : null,
                                                                                      activeColor: FlutterFlowTheme.of(context).accent1,
                                                                                      checkColor: FlutterFlowTheme.of(context).info,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    todayTasksListGardenTasksRecord.objective.maybeHandleOverflow(
                                                                                      maxChars: 30,
                                                                                      replacement: '…',
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: StreamBuilder<
                                                                        List<
                                                                            PlantTasksRecord>>(
                                                                      stream:
                                                                          queryPlantTasksRecord(
                                                                        queryBuilder: (plantTasksRecord) => plantTasksRecord
                                                                            .where(
                                                                              'userCreatorID',
                                                                              isEqualTo: currentUserUid,
                                                                            )
                                                                            .where(
                                                                              'gardenCreatorRef',
                                                                              isEqualTo: columnGardensRecord.reference,
                                                                            ),
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                        List<PlantTasksRecord>
                                                                            todayTasksListPlantTasksRecordList =
                                                                            snapshot.data!;

                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: List.generate(
                                                                              todayTasksListPlantTasksRecordList.length,
                                                                              (todayTasksListIndex) {
                                                                            final todayTasksListPlantTasksRecord =
                                                                                todayTasksListPlantTasksRecordList[todayTasksListIndex];
                                                                            return Visibility(
                                                                              visible: functions.checkToday(todayTasksListPlantTasksRecord.startDate!, todayTasksListPlantTasksRecord.frequencyNum, todayTasksListPlantTasksRecord.frequencyType),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Theme(
                                                                                    data: ThemeData(
                                                                                      checkboxTheme: CheckboxThemeData(
                                                                                        visualDensity: VisualDensity.compact,
                                                                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(4.0),
                                                                                        ),
                                                                                      ),
                                                                                      unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                    ),
                                                                                    child: Checkbox(
                                                                                      value: _model.checkboxValueMap2[todayTasksListPlantTasksRecord] ??= todayTasksListPlantTasksRecord.completedToday,
                                                                                      onChanged: (newValue) async {
                                                                                        safeSetState(() => _model.checkboxValueMap2[todayTasksListPlantTasksRecord] = newValue!);
                                                                                        if (newValue!) {
                                                                                          await todayTasksListPlantTasksRecord.reference.update(createPlantTasksRecordData(
                                                                                            completedToday: true,
                                                                                          ));
                                                                                        } else {
                                                                                          await todayTasksListPlantTasksRecord.reference.update(createPlantTasksRecordData(
                                                                                            completedToday: false,
                                                                                          ));
                                                                                        }
                                                                                      },
                                                                                      side: (FlutterFlowTheme.of(context).secondaryText != null)
                                                                                          ? BorderSide(
                                                                                              width: 2,
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            )
                                                                                          : null,
                                                                                      activeColor: FlutterFlowTheme.of(context).primary,
                                                                                      checkColor: FlutterFlowTheme.of(context).info,
                                                                                    ),
                                                                                  ),
                                                                                  StreamBuilder<PlantsRecord>(
                                                                                    stream: PlantsRecord.getDocument(todayTasksListPlantTasksRecord.plantCreatorRef!),
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

                                                                                      final textPlantsRecord = snapshot.data!;

                                                                                      return Text(
                                                                                        '${textPlantsRecord.plantID}: ${todayTasksListPlantTasksRecord.objective}'.maybeHandleOverflow(
                                                                                          maxChars: 30,
                                                                                          replacement: '…',
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if (Navigator.of(context)
                                                  .canPop()) {
                                                context.pop();
                                              }
                                              context.pushNamed(
                                                  TabsWidget.routeName);
                                            },
                                            child: Container(
                                              width: 350.0,
                                              height: 49.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(24.0),
                                                  bottomRight:
                                                      Radius.circular(24.0),
                                                  topLeft: Radius.circular(0.0),
                                                  topRight:
                                                      Radius.circular(0.0),
                                                ),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  'View More',
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
                                                        fontSize: 24.0,
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
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
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
                        ],
                      ),
                      if (currentUserEmail == '')
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 1.0,
                              decoration: BoxDecoration(
                                color: Color(0x4D242424),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 50.0, 0.0, 0.0),
                                    child: Container(
                                      width: 251.0,
                                      height: 165.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 10.0),
                                            child: Text(
                                              'Log in to access My Home!',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
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
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 10.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                context.pushNamed(
                                                    LogInPageWidget.routeName);
                                              },
                                              text: 'sign in',
                                              options: FFButtonOptions(
                                                width: 150.0,
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        24.0, 0.0, 24.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                elevation: 3.0,
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                          ),
                                          FFButtonWidget(
                                            onPressed: () async {
                                              context.pushNamed(
                                                  RegisterPageWidget.routeName);
                                            },
                                            text: 'register',
                                            options: FFButtonOptions(
                                              width: 150.0,
                                              height: 40.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      24.0, 0.0, 24.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                                    color: Colors.white,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w300,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                              elevation: 3.0,
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
