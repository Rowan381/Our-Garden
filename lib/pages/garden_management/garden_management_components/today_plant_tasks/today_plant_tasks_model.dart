import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'today_plant_tasks_widget.dart' show TodayPlantTasksWidget;
import 'package:flutter/material.dart';

class TodayPlantTasksModel extends FlutterFlowModel<TodayPlantTasksWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for CheckboxGroup widget.
  FormFieldController<List<String>>? checkboxGroupValueController;
  List<String>? get checkboxGroupValues => checkboxGroupValueController?.value;
  set checkboxGroupValues(List<String>? v) =>
      checkboxGroupValueController?.value = v;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
