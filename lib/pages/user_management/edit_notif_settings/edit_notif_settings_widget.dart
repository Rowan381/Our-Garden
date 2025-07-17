import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_notif_settings_model.dart';
export 'edit_notif_settings_model.dart';

class EditNotifSettingsWidget extends StatefulWidget {
  const EditNotifSettingsWidget({super.key});

  static String routeName = 'Edit_Notif_Settings';
  static String routePath = '/editNotifSettings';

  @override
  State<EditNotifSettingsWidget> createState() =>
      _EditNotifSettingsWidgetState();
}

class _EditNotifSettingsWidgetState extends State<EditNotifSettingsWidget> {
  late EditNotifSettingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditNotifSettingsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!(currentUserDocument?.notificationSettingsRef != null)) {
        var notificationSettingsRecordReference =
            NotificationSettingsRecord.collection.doc();
        await notificationSettingsRecordReference
            .set(createNotificationSettingsRecordData(
          allNotifications: true,
          messages: true,
          sellerApprovedRequests: true,
          priceChanges: true,
          newLocalListing: true,
          newReview: true,
          lowInventory: true,
          incomingRequest: true,
          someoneFavorited: true,
        ));
        _model.newSettings = NotificationSettingsRecord.getDocumentFromData(
            createNotificationSettingsRecordData(
              allNotifications: true,
              messages: true,
              sellerApprovedRequests: true,
              priceChanges: true,
              newLocalListing: true,
              newReview: true,
              lowInventory: true,
              incomingRequest: true,
              someoneFavorited: true,
            ),
            notificationSettingsRecordReference);

        await currentUserReference!.update(createUsersRecordData(
          notificationSettingsRef: _model.newSettings?.reference,
        ));
      }
      _model.loaded = true;
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
          title: Text(
            'Notifications',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.ibmPlexMono(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 27.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Visibility(
            visible: _model.loaded,
            child: AuthUserStreamWidget(
              builder: (context) => StreamBuilder<NotificationSettingsRecord>(
                stream: NotificationSettingsRecord.getDocument(
                    currentUserDocument!.notificationSettingsRef!),
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

                  final columnNotificationSettingsRecord = snapshot.data!;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width * 0.1,
                                      0.0,
                                    ),
                                    0.0,
                                    0.0,
                                    0.0),
                                child: Text(
                                  'All Notifications',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        fontSize: 19.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0,
                                      0.0,
                                      valueOrDefault<double>(
                                        MediaQuery.sizeOf(context).width * 0.05,
                                        0.0,
                                      ),
                                      0.0),
                                  child: Switch.adaptive(
                                    value: _model.switchValue1 ??=
                                        columnNotificationSettingsRecord
                                            .allNotifications,
                                    onChanged: (newValue) async {
                                      safeSetState(() =>
                                          _model.switchValue1 = newValue);
                                      if (newValue) {
                                        unawaited(
                                          () async {
                                            await columnNotificationSettingsRecord
                                                .reference
                                                .update(
                                                    createNotificationSettingsRecordData(
                                              allNotifications: true,
                                            ));
                                          }(),
                                        );
                                      } else {
                                        unawaited(
                                          () async {
                                            await columnNotificationSettingsRecord
                                                .reference
                                                .update(
                                                    createNotificationSettingsRecordData(
                                              allNotifications: false,
                                            ));
                                          }(),
                                        );
                                      }
                                    },
                                    activeColor:
                                        FlutterFlowTheme.of(context).primary,
                                    activeTrackColor:
                                        FlutterFlowTheme.of(context).accent1,
                                    inactiveTrackColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    inactiveThumbColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  valueOrDefault<double>(
                                    MediaQuery.sizeOf(context).width * 0.1,
                                    0.0,
                                  ),
                                  0.0,
                                  0.0,
                                  0.0),
                              child: Text(
                                'Messages',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 19.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    0.0,
                                    valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width * 0.05,
                                      0.0,
                                    ),
                                    0.0),
                                child: Switch.adaptive(
                                  value: _model.switchValue2 ??=
                                      columnNotificationSettingsRecord.messages,
                                  onChanged: (newValue) async {
                                    safeSetState(
                                        () => _model.switchValue2 = newValue);
                                    if (newValue) {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            messages: true,
                                          ));
                                        }(),
                                      );
                                    } else {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            messages: false,
                                          ));
                                        }(),
                                      );
                                    }
                                  },
                                  activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                  activeTrackColor:
                                      FlutterFlowTheme.of(context).accent1,
                                  inactiveTrackColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  inactiveThumbColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                valueOrDefault<double>(
                                  MediaQuery.sizeOf(context).width * 0.31,
                                  0.0,
                                ),
                                5.0,
                                0.0,
                                5.0),
                            child: Text(
                              'OurMarket',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 24.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 0.0, 0.0),
                                child: Icon(
                                  FFIcons.kstore,
                                  color: FlutterFlowTheme.of(context).secondary,
                                  size: 45.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          '——————   Buying   ——————',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  valueOrDefault<double>(
                                    MediaQuery.sizeOf(context).width * 0.1,
                                    0.0,
                                  ),
                                  0.0,
                                  0.0,
                                  0.0),
                              child: Text(
                                'Favorite Item Price Change',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 19.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    0.0,
                                    valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width * 0.05,
                                      0.0,
                                    ),
                                    0.0),
                                child: Switch.adaptive(
                                  value: _model.switchValue3 ??=
                                      columnNotificationSettingsRecord
                                          .priceChanges,
                                  onChanged: (newValue) async {
                                    safeSetState(
                                        () => _model.switchValue3 = newValue);
                                    if (newValue) {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            priceChanges: true,
                                          ));
                                        }(),
                                      );
                                    } else {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            priceChanges: false,
                                          ));
                                        }(),
                                      );
                                    }
                                  },
                                  activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                  activeTrackColor:
                                      FlutterFlowTheme.of(context).accent1,
                                  inactiveTrackColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  inactiveThumbColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  valueOrDefault<double>(
                                    MediaQuery.sizeOf(context).width * 0.1,
                                    0.0,
                                  ),
                                  0.0,
                                  0.0,
                                  0.0),
                              child: Text(
                                'New Local Listings',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 19.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    0.0,
                                    valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width * 0.05,
                                      0.0,
                                    ),
                                    0.0),
                                child: Switch.adaptive(
                                  value: _model.switchValue4 ??=
                                      columnNotificationSettingsRecord
                                          .newLocalListing,
                                  onChanged: (newValue) async {
                                    safeSetState(
                                        () => _model.switchValue4 = newValue);
                                    if (newValue) {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            newLocalListing: true,
                                          ));
                                        }(),
                                      );
                                    } else {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            newLocalListing: false,
                                          ));
                                        }(),
                                      );
                                    }
                                  },
                                  activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                  activeTrackColor:
                                      FlutterFlowTheme.of(context).accent1,
                                  inactiveTrackColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  inactiveThumbColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  valueOrDefault<double>(
                                    MediaQuery.sizeOf(context).width * 0.1,
                                    0.0,
                                  ),
                                  0.0,
                                  0.0,
                                  0.0),
                              child: Text(
                                'Seller Approved Request',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 19.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    0.0,
                                    valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width * 0.05,
                                      0.0,
                                    ),
                                    0.0),
                                child: Switch.adaptive(
                                  value: _model.switchValue5 ??=
                                      columnNotificationSettingsRecord
                                          .sellerApprovedRequests,
                                  onChanged: (newValue) async {
                                    safeSetState(
                                        () => _model.switchValue5 = newValue);
                                    if (newValue) {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            sellerApprovedRequests: true,
                                          ));
                                        }(),
                                      );
                                    } else {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            sellerApprovedRequests: false,
                                          ));
                                        }(),
                                      );
                                    }
                                  },
                                  activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                  activeTrackColor:
                                      FlutterFlowTheme.of(context).accent1,
                                  inactiveTrackColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  inactiveThumbColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          ' ——————   Selling   ——————',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  valueOrDefault<double>(
                                    MediaQuery.sizeOf(context).width * 0.1,
                                    0.0,
                                  ),
                                  0.0,
                                  0.0,
                                  0.0),
                              child: Text(
                                'Low Inventory',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 19.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    0.0,
                                    valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width * 0.05,
                                      0.0,
                                    ),
                                    0.0),
                                child: Switch.adaptive(
                                  value: _model.switchValue6 ??=
                                      columnNotificationSettingsRecord
                                          .lowInventory,
                                  onChanged: (newValue) async {
                                    safeSetState(
                                        () => _model.switchValue6 = newValue);
                                    if (newValue) {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            lowInventory: true,
                                          ));
                                        }(),
                                      );
                                    } else {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            lowInventory: false,
                                          ));
                                        }(),
                                      );
                                    }
                                  },
                                  activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                  activeTrackColor:
                                      FlutterFlowTheme.of(context).accent1,
                                  inactiveTrackColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  inactiveThumbColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  valueOrDefault<double>(
                                    MediaQuery.sizeOf(context).width * 0.1,
                                    0.0,
                                  ),
                                  0.0,
                                  0.0,
                                  0.0),
                              child: Text(
                                'Listing was Favorited',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 19.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    0.0,
                                    valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width * 0.05,
                                      0.0,
                                    ),
                                    0.0),
                                child: Switch.adaptive(
                                  value: _model.switchValue7 ??=
                                      columnNotificationSettingsRecord
                                          .someoneFavorited,
                                  onChanged: (newValue) async {
                                    safeSetState(
                                        () => _model.switchValue7 = newValue);
                                    if (newValue) {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            someoneFavorited: true,
                                          ));
                                        }(),
                                      );
                                    } else {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            someoneFavorited: false,
                                          ));
                                        }(),
                                      );
                                    }
                                  },
                                  activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                  activeTrackColor:
                                      FlutterFlowTheme.of(context).accent1,
                                  inactiveTrackColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  inactiveThumbColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  valueOrDefault<double>(
                                    MediaQuery.sizeOf(context).width * 0.1,
                                    0.0,
                                  ),
                                  0.0,
                                  0.0,
                                  0.0),
                              child: Text(
                                'Incoming Request',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 19.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    0.0,
                                    valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width * 0.05,
                                      0.0,
                                    ),
                                    0.0),
                                child: Switch.adaptive(
                                  value: _model.switchValue8 ??=
                                      columnNotificationSettingsRecord
                                          .incomingRequest,
                                  onChanged: (newValue) async {
                                    safeSetState(
                                        () => _model.switchValue8 = newValue);
                                    if (newValue) {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            incomingRequest: true,
                                          ));
                                        }(),
                                      );
                                    } else {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            incomingRequest: false,
                                          ));
                                        }(),
                                      );
                                    }
                                  },
                                  activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                  activeTrackColor:
                                      FlutterFlowTheme.of(context).accent1,
                                  inactiveTrackColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  inactiveThumbColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  valueOrDefault<double>(
                                    MediaQuery.sizeOf(context).width * 0.1,
                                    0.0,
                                  ),
                                  0.0,
                                  0.0,
                                  0.0),
                              child: Text(
                                'New Review',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 19.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Align(
                              alignment: AlignmentDirectional(1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0,
                                    0.0,
                                    valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width * 0.05,
                                      0.0,
                                    ),
                                    0.0),
                                child: Switch.adaptive(
                                  value: _model.switchValue9 ??=
                                      columnNotificationSettingsRecord
                                          .newReview,
                                  onChanged: (newValue) async {
                                    safeSetState(
                                        () => _model.switchValue9 = newValue);
                                    if (newValue) {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            newReview: true,
                                          ));
                                        }(),
                                      );
                                    } else {
                                      unawaited(
                                        () async {
                                          await columnNotificationSettingsRecord
                                              .reference
                                              .update(
                                                  createNotificationSettingsRecordData(
                                            newReview: false,
                                          ));
                                        }(),
                                      );
                                    }
                                  },
                                  activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                  activeTrackColor:
                                      FlutterFlowTheme.of(context).accent1,
                                  inactiveTrackColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  inactiveThumbColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
