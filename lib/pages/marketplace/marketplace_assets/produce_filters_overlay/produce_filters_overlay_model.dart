import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'produce_filters_overlay_widget.dart' show ProduceFiltersOverlayWidget;
import 'package:flutter/material.dart';

class ProduceFiltersOverlayModel
    extends FlutterFlowModel<ProduceFiltersOverlayWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for produceCheckboxGrp widget.
  FormFieldController<List<String>>? produceCheckboxGrpValueController;
  List<String>? get produceCheckboxGrpValues =>
      produceCheckboxGrpValueController?.value;
  set produceCheckboxGrpValues(List<String>? v) =>
      produceCheckboxGrpValueController?.value = v;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
