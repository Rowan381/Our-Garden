import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'garden_filters_overlay_model.dart';
export 'garden_filters_overlay_model.dart';

class GardenFiltersOverlayWidget extends StatefulWidget {
  const GardenFiltersOverlayWidget({super.key});

  @override
  State<GardenFiltersOverlayWidget> createState() =>
      _GardenFiltersOverlayWidgetState();
}

class _GardenFiltersOverlayWidgetState
    extends State<GardenFiltersOverlayWidget> {
  late GardenFiltersOverlayModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GardenFiltersOverlayModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 393.0,
              height: 413.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            30.0, 20.0, 0.0, 0.0),
                        child: Text(
                          'Plant Type:',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.ibmPlexMono(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            205.0, 10.0, 0.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              50.0, 10.0, 0.0, 0.0),
                          child: FlutterFlowCheckboxGroup(
                            options: [
                              'Houseplant',
                              'Tree & Shrub',
                              'Vegetables',
                              'Fruit',
                              'Succulents',
                              'Annuals',
                              'Perennials'
                            ],
                            onChanged: (val) async {
                              safeSetState(
                                  () => _model.plantCheckboxGrpValues = val);
                              FFAppState().postListingFilters = _model
                                  .plantCheckboxGrpValues!
                                  .toList()
                                  .cast<String>();
                              _model.updatePage(() {});
                            },
                            controller:
                                _model.plantCheckboxGrpValueController ??=
                                    FormFieldController<List<String>>(
                              [],
                            ),
                            activeColor: FlutterFlowTheme.of(context).secondary,
                            checkColor: FlutterFlowTheme.of(context).info,
                            checkboxBorderColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.ibmPlexMono(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            checkboxBorderRadius: BorderRadius.circular(4.0),
                            initialized: _model.plantCheckboxGrpValues != null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
