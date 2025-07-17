import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'garden_filters_overlay_widget.dart' show GardenFiltersOverlayWidget;
import 'package:flutter/material.dart';

class GardenFiltersOverlayModel
    extends FlutterFlowModel<GardenFiltersOverlayWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for plantCheckboxGrp widget.
  FormFieldController<List<String>>? plantCheckboxGrpValueController;
  List<String>? get plantCheckboxGrpValues =>
      plantCheckboxGrpValueController?.value;
  set plantCheckboxGrpValues(List<String>? v) =>
      plantCheckboxGrpValueController?.value = v;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
