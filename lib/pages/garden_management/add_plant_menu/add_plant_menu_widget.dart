import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_plant_menu_model.dart';
export 'add_plant_menu_model.dart';

class AddPlantMenuWidget extends StatefulWidget {
  const AddPlantMenuWidget({
    super.key,
    this.gardenDestination,
  });

  final GardensRecord? gardenDestination;

  static String routeName = 'addPlantMenu';
  static String routePath = '/addPlantMenu';

  @override
  State<AddPlantMenuWidget> createState() => _AddPlantMenuWidgetState();
}

class _AddPlantMenuWidgetState extends State<AddPlantMenuWidget> {
  late AddPlantMenuModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddPlantMenuModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: SafeArea(
            top: true,
            child: Form(
              key: _model.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 0.0, 0.0, 0.0),
                            child: FlutterFlowIconButton(
                              borderRadius: 20.0,
                              borderWidth: 0.0,
                              buttonSize: 48.0,
                              fillColor: Color(0x000FFFFF),
                              icon: Icon(
                                Icons.arrow_back,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              onPressed: () async {
                                context.safePop();
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            'Add Plant',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  font: GoogleFonts.ibmPlexMono(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 32.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 0.0),
                          child: Text(
                            'Would you like to search for a common plant or create your own?',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  font: GoogleFonts.ibmPlexMono(
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 30.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed(
                                AddCommonPlantWidget.routeName,
                                queryParameters: {
                                  'gardenDest': serializeParam(
                                    widget.gardenDestination,
                                    ParamType.Document,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  'gardenDest': widget.gardenDestination,
                                },
                              );
                            },
                            text: 'Common Plant',
                            icon: Icon(
                              FFIcons.kflowers,
                              size: 50.0,
                            ),
                            options: FFButtonOptions(
                              width: 290.0,
                              height: 120.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 20.0),
                              iconColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              color: Color(0xFFEDEDED),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.ibmPlexMono(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 22.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed(
                                AddCustomPlantWidget.routeName,
                                queryParameters: {
                                  'gardenDest': serializeParam(
                                    widget.gardenDestination,
                                    ParamType.Document,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  'gardenDest': widget.gardenDestination,
                                },
                              );
                            },
                            text: 'Custom Plant',
                            icon: Icon(
                              FFIcons.kicons8PottedPlant100,
                              size: 50.0,
                            ),
                            options: FFButtonOptions(
                              width: 290.0,
                              height: 120.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 20.0),
                              iconColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              color: Color(0xFFEDEDED),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.ibmPlexMono(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 22.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed(AddNewSpeciesWidget.routeName);
                            },
                            text: 'New Species',
                            icon: Icon(
                              FFIcons.kicons8Lotus96,
                              size: 50.0,
                            ),
                            options: FFButtonOptions(
                              width: 290.0,
                              height: 120.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 10.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 20.0),
                              iconColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              color: Color(0xFFEDEDED),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.ibmPlexMono(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 22.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(16.0),
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
      ),
    );
  }
}
