import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_plant_task_menu_model.dart';
export 'edit_plant_task_menu_model.dart';

class EditPlantTaskMenuWidget extends StatefulWidget {
  const EditPlantTaskMenuWidget({
    super.key,
    required this.pTaskList,
  });

  final List<PlantTasksRecord>? pTaskList;

  @override
  State<EditPlantTaskMenuWidget> createState() =>
      _EditPlantTaskMenuWidgetState();
}

class _EditPlantTaskMenuWidgetState extends State<EditPlantTaskMenuWidget> {
  late EditPlantTaskMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditPlantTaskMenuModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.pTaskListLen = widget.pTaskList?.length;
      safeSetState(() {});
      _model.pTaskListLen = _model.pTaskListLen! + -1;
      safeSetState(() {});
      while (_model.pTaskListLen! >= 0) {
        _model.currPlantDoc = await PlantsRecord.getDocumentOnce(widget
            .pTaskList!
            .elementAtOrNull(_model.pTaskListLen!)!
            .plantCreatorRef!);
        _model.addToPTaskListDisplay(
            '${_model.currPlantDoc?.plantID} — ${widget.pTaskList?.elementAtOrNull(_model.pTaskListLen!)?.objective}');
        safeSetState(() {});
        _model.pTaskListLen = _model.pTaskListLen! + -1;
        safeSetState(() {});
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
    return Container(
      width: double.infinity,
      height: 231.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Color(0x3B1D2429),
            offset: Offset(
              0.0,
              -3.0,
            ),
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Choose a Plant Task',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.ibmPlexMono(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    fontSize: 24.0,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
            Form(
              key: _model.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                child: FlutterFlowDropDown<String>(
                  controller: _model.dropDownValueController ??=
                      FormFieldController<String>(
                    _model.dropDownValue ??=
                        _model.pTaskListDisplay.firstOrNull,
                  ),
                  options: _model.pTaskListDisplay,
                  onChanged: (val) =>
                      safeSetState(() => _model.dropDownValue = val),
                  width: 300.0,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.ibmPlexMono(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  elevation: 2.0,
                  borderColor: FlutterFlowTheme.of(context).alternate,
                  borderWidth: 2.0,
                  borderRadius: 8.0,
                  margin: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  hidesUnderline: true,
                  isOverButton: true,
                  isSearchable: false,
                  isMultiSelect: false,
                  labelText: 'Choose task',
                  labelTextStyle: FlutterFlowTheme.of(context)
                      .labelMedium
                      .override(
                        font: GoogleFonts.ibmPlexMono(
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                      ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    if (_model.formKey.currentState == null ||
                        !_model.formKey.currentState!.validate()) {
                      return;
                    }
                    if (_model.dropDownValue == null) {
                      return;
                    }
                    _model.nameObjList = await actions.newCustomAction(
                      _model.dropDownValue!,
                    );
                    _model.chosenPlantDoc = await queryPlantsRecordOnce(
                      queryBuilder: (plantsRecord) => plantsRecord
                          .where(
                            'gardenCreatorRef',
                            isEqualTo: _model.currPlantDoc?.gardenCreatorRef,
                          )
                          .where(
                            'plantID',
                            isEqualTo: _model.nameObjList?.firstOrNull,
                          ),
                      singleRecord: true,
                    ).then((s) => s.firstOrNull);
                    _model.chosenPTaskDoc = await queryPlantTasksRecordOnce(
                      queryBuilder: (plantTasksRecord) => plantTasksRecord
                          .where(
                            'plantCreatorRef',
                            isEqualTo: _model.chosenPlantDoc?.reference,
                          )
                          .where(
                            'objective',
                            isEqualTo: _model.nameObjList?.lastOrNull,
                          ),
                      singleRecord: true,
                    ).then((s) => s.firstOrNull);
                    Navigator.pop(context);

                    context.pushNamed(
                      EditPlantTaskWidget.routeName,
                      queryParameters: {
                        'plantTask': serializeParam(
                          _model.chosenPTaskDoc,
                          ParamType.Document,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        'plantTask': _model.chosenPTaskDoc,
                      },
                    );

                    safeSetState(() {});
                  },
                  text: 'Edit',
                  options: FFButtonOptions(
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).secondary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.ibmPlexMono(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: Colors.white,
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
