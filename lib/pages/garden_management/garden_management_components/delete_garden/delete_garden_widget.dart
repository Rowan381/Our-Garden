import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'delete_garden_model.dart';
export 'delete_garden_model.dart';

class DeleteGardenWidget extends StatefulWidget {
  const DeleteGardenWidget({
    super.key,
    required this.gardenDoc,
  });

  final GardensRecord? gardenDoc;

  @override
  State<DeleteGardenWidget> createState() => _DeleteGardenWidgetState();
}

class _DeleteGardenWidgetState extends State<DeleteGardenWidget> {
  late DeleteGardenModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeleteGardenModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.gardenTasksList = await queryGardenTasksRecordOnce(
        queryBuilder: (gardenTasksRecord) => gardenTasksRecord.where(
          'gardenCreatorRef',
          isEqualTo: widget.gardenDoc?.reference,
        ),
      );
      _model.plantsList = await queryPlantsRecordOnce(
        queryBuilder: (plantsRecord) => plantsRecord.where(
          'gardenCreatorRef',
          isEqualTo: widget.gardenDoc?.reference,
        ),
      );
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
      height: 270.0,
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
              'Confirm Garden Deletion',
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
              child: Text(
                'This will also delete all associated plants and tasks.',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.ibmPlexMono(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  _model.plantsListLen = _model.plantsList?.length;
                  _model.plantsListLen = _model.plantsListLen! + -1;
                  while (_model.plantsListLen! >= 0) {
                    _model.currPlantTasksList = await queryPlantTasksRecordOnce(
                      queryBuilder: (plantTasksRecord) => plantTasksRecord
                          .where(
                            'plantCreatorRef',
                            isEqualTo: _model.plantsList
                                ?.elementAtOrNull(_model.plantsListLen!)
                                ?.reference,
                          )
                          .where(
                            'userCreatorID',
                            isEqualTo: currentUserUid,
                          ),
                    );
                    _model.currPlantTasksListLen =
                        _model.currPlantTasksList?.length;
                    _model.currPlantTasksListLen =
                        _model.currPlantTasksListLen! + -1;
                    while (_model.currPlantTasksListLen! >= 0) {
                      await _model.currPlantTasksList!
                          .elementAtOrNull(_model.currPlantTasksListLen!)!
                          .reference
                          .delete();
                      _model.currPlantTasksListLen =
                          _model.currPlantTasksListLen! + -1;
                    }
                    await _model.plantsList!
                        .elementAtOrNull(_model.plantsListLen!)!
                        .reference
                        .delete();
                    _model.plantsListLen = _model.plantsListLen! + -1;
                    safeSetState(() {});
                  }
                  _model.gardenTasksListLen = _model.gardenTasksList?.length;
                  _model.gardenTasksListLen = _model.gardenTasksListLen! + -1;
                  while (_model.gardenTasksListLen! >= 0) {
                    await _model.gardenTasksList!
                        .elementAtOrNull(_model.gardenTasksListLen!)!
                        .reference
                        .delete();
                    _model.gardenTasksListLen = _model.gardenTasksListLen! + -1;
                    safeSetState(() {});
                  }
                  await widget.gardenDoc!.reference.delete();
                  Navigator.pop(context);

                  context.goNamed(TabsWidget.routeName);

                  safeSetState(() {});
                },
                text: 'Delete Garden',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFFA3333D),
                  textStyle:
                      FlutterFlowTheme.of(context).headlineLarge.override(
                            font: GoogleFonts.ibmPlexMono(
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .headlineLarge
                                  .fontStyle,
                            ),
                            color: Colors.white,
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineLarge
                                .fontStyle,
                          ),
                  elevation: 2.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  Navigator.pop(context);
                },
                text: 'Cancel',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 60.0,
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Color(0xFFD9D9D9),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.ibmPlexMono(
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: Colors.black,
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
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
