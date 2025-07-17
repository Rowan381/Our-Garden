import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'location_services_model.dart';
export 'location_services_model.dart';

class LocationServicesWidget extends StatefulWidget {
  const LocationServicesWidget({super.key});

  static String routeName = 'locationServices';
  static String routePath = '/locationServices';

  @override
  State<LocationServicesWidget> createState() => _LocationServicesWidgetState();
}

class _LocationServicesWidgetState extends State<LocationServicesWidget> {
  late LocationServicesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LocationServicesModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      while (_model.placePickerValue == null) {
        await Future.delayed(const Duration(milliseconds: 10));
      }
      await _model.googleMapsController.future.then(
        (c) => c.animateCamera(
          CameraUpdate.newLatLng(_model.placePickerValue.latLng.toGoogleMaps()),
        ),
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
    return FutureBuilder<ApiCallResponse>(
      future: LatLongReverseGeoCall.call(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
        final locationServicesLatLongReverseGeoResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              key: scaffoldKey,
              resizeToAvoidBottomInset: false,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              appBar: AppBar(
                backgroundColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
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
                    context.pop();
                  },
                ),
                title: Text(
                  'Location Services',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.ibmPlexMono(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 27.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
                actions: [],
                centerTitle: false,
              ),
              body: SafeArea(
                top: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Current Set Location:',
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
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                  AuthUserStreamWidget(
                                    builder: (context) => Text(
                                      valueOrDefault<String>(
                                        (valueOrDefault(
                                                            currentUserDocument
                                                                ?.city,
                                                            '') ==
                                                        '') &&
                                                (valueOrDefault(
                                                            currentUserDocument
                                                                ?.state,
                                                            '') ==
                                                        '')
                                            ? 'None'
                                            : valueOrDefault<String>(
                                                '${valueOrDefault<String>(
                                                  valueOrDefault(
                                                      currentUserDocument?.city,
                                                      ''),
                                                  'N/A',
                                                )}, ${valueOrDefault<String>(
                                                  valueOrDefault(
                                                      currentUserDocument
                                                          ?.state,
                                                      ''),
                                                  'N/A',
                                                )}',
                                                'None',
                                              ),
                                        'None',
                                      ),
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
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context).secondary,
                            borderRadius: 8.0,
                            borderWidth: 1.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).secondary,
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: FlutterFlowTheme.of(context).info,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              await currentUserReference!.update({
                                ...mapToFirestore(
                                  {
                                    'location': FieldValue.delete(),
                                    'city': FieldValue.delete(),
                                    'state': FieldValue.delete(),
                                  },
                                ),
                              });
                              await _model.googleMapsController.future.then(
                                (c) => c.animateCamera(
                                  CameraUpdate.newLatLng(currentUserDocument!
                                      .location!
                                      .toGoogleMaps()),
                                ),
                              );
                            },
                          ),
                          FutureBuilder<ApiCallResponse>(
                            future: LatLongReverseGeoCall.call(),
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
                              final placePickerLatLongReverseGeoResponse =
                                  snapshot.data!;

                              return FlutterFlowPlacePicker(
                                iOSGoogleMapsApiKey:
                                    'AIzaSyCjihyDgqyrt6W1SeEpPG3338G2D69Z6lU',
                                androidGoogleMapsApiKey:
                                    'AIzaSyBYngARUTyMcU9SSxTXxZmGAPWZaGX7DkQ',
                                webGoogleMapsApiKey:
                                    'AIzaSyDAXJp9jAOeWYvk5SDvIBF26FqCFMAE3yQ',
                                onSelect: (place) async {
                                  safeSetState(
                                      () => _model.placePickerValue = place);
                                  (await _model.googleMapsController.future)
                                      .animateCamera(CameraUpdate.newLatLng(
                                          place.latLng.toGoogleMaps()));
                                },
                                defaultText: 'Choose Location',
                                icon: Icon(
                                  Icons.place,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 18.0,
                                ),
                                buttonOptions: FFButtonOptions(
                                  width: 200.0,
                                  height: 40.0,
                                  color: FlutterFlowTheme.of(context).secondary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 2.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              );
                            },
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              await currentUserReference!
                                  .update(createUsersRecordData(
                                location: _model.placePickerValue.latLng,
                                city: valueOrDefault<String>(
                                  _model.placePickerValue.city,
                                  'N/A',
                                ),
                                state: valueOrDefault<String>(
                                  _model.placePickerValue.state,
                                  'N/A',
                                ),
                              ));
                              FFAppState().canChangeWeather = true;
                                                          context.safePop();
                            },
                            text: 'Confirm',
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).secondary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: AuthUserStreamWidget(
                        builder: (context) => FlutterFlowGoogleMap(
                          controller: _model.googleMapsController,
                          onCameraIdle: (latLng) =>
                              _model.googleMapsCenter = latLng,
                          initialLocation: _model.googleMapsCenter ??=
                              currentUserDocument?.location != null
                                  ? currentUserDocument!.location!
                                  : _model.placePickerValue.latLng,
                          markerColor: GoogleMarkerColor.cyan,
                          mapType: MapType.normal,
                          style: GoogleMapStyle.standard,
                          initialZoom: 14.0,
                          allowInteraction: true,
                          allowZoom: true,
                          showZoomControls: false,
                          showLocation: true,
                          showCompass: false,
                          showMapToolbar: false,
                          showTraffic: false,
                          centerMapOnMarkerTap: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
