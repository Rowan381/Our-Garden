import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'garden_tasks_widget.dart' show GardenTasksWidget;
import 'package:flutter/material.dart';

class GardenTasksModel extends FlutterFlowModel<GardenTasksWidget> {
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
