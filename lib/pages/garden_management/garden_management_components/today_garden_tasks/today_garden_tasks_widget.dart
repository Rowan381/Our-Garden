import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'today_garden_tasks_model.dart';
export 'today_garden_tasks_model.dart';

class TodayGardenTasksWidget extends StatefulWidget {
  const TodayGardenTasksWidget({
    super.key,
    this.parameter1,
  });

  final List<String>? parameter1;

  @override
  State<TodayGardenTasksWidget> createState() => _TodayGardenTasksWidgetState();
}

class _TodayGardenTasksWidgetState extends State<TodayGardenTasksWidget> {
  late TodayGardenTasksModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TodayGardenTasksModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterFlowCheckboxGroup(
      options: widget.parameter1!.toList(),
      onChanged: (val) => safeSetState(() => _model.checkboxGroupValues = val),
      controller: _model.checkboxGroupValueController ??=
          FormFieldController<List<String>>(
        [],
      ),
      activeColor: Color(0xFF72B589),
      checkColor: FlutterFlowTheme.of(context).info,
      checkboxBorderColor: FlutterFlowTheme.of(context).primaryText,
      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
            font: GoogleFonts.ibmPlexMono(
              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
            ),
            letterSpacing: 0.0,
            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
          ),
      checkboxBorderRadius: BorderRadius.circular(4.0),
      initialized: _model.checkboxGroupValues != null,
    );
  }
}
