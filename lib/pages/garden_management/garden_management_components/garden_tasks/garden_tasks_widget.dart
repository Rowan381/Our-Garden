import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'garden_tasks_model.dart';
export 'garden_tasks_model.dart';

class GardenTasksWidget extends StatefulWidget {
  const GardenTasksWidget({
    super.key,
    this.parameter1,
    this.parameter2,
  });

  final List<String>? parameter1;
  final DocumentReference? parameter2;

  @override
  State<GardenTasksWidget> createState() => _GardenTasksWidgetState();
}

class _GardenTasksWidgetState extends State<GardenTasksWidget> {
  late GardenTasksModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GardenTasksModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
      child: StreamBuilder<List<GardenTasksRecord>>(
        stream: queryGardenTasksRecord(
          queryBuilder: (gardenTasksRecord) => gardenTasksRecord
              .where(
                'gardenCreatorRef',
                isEqualTo: widget.parameter2,
              )
              .where(
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
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            );
          }
          List<GardenTasksRecord> checkboxGroupGardenTasksRecordList =
              snapshot.data!;

          return FlutterFlowCheckboxGroup(
            options: checkboxGroupGardenTasksRecordList
                .where((e) => functions.checkToday(
                    e.startDate!, e.frequencyNum, e.frequencyType))
                .toList()
                .map((e) => e.objective)
                .toList(),
            onChanged: (val) =>
                safeSetState(() => _model.checkboxGroupValues = val),
            controller: _model.checkboxGroupValueController ??=
                FormFieldController<List<String>>(
              [],
            ),
            activeColor: Color(0xFF72B589),
            checkColor: FlutterFlowTheme.of(context).info,
            checkboxBorderColor: FlutterFlowTheme.of(context).primaryText,
            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.ibmPlexMono(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
            labelPadding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
            checkboxBorderRadius: BorderRadius.circular(4.0),
            initialized: _model.checkboxGroupValues != null,
          );
        },
      ),
    );
  }
}
