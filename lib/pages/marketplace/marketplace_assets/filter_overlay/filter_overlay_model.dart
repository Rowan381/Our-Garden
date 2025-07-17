import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'filter_overlay_widget.dart' show FilterOverlayWidget;
import 'package:flutter/material.dart';

class FilterOverlayModel extends FlutterFlowModel<FilterOverlayWidget> {
  ///  Local state fields for this component.

  bool filtersImplemented = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for categoryChips widget.
  FormFieldController<List<String>>? categoryChipsValueController;
  String? get categoryChipsValue =>
      categoryChipsValueController?.value?.firstOrNull;
  set categoryChipsValue(String? val) =>
      categoryChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue;
  // State field(s) for distanceDropdown widget.
  String? distanceDropdownValue;
  FormFieldController<String>? distanceDropdownValueController;
  // State field(s) for produceCheckboxGrp widget.
  FormFieldController<List<String>>? produceCheckboxGrpValueController;
  List<String>? get produceCheckboxGrpValues =>
      produceCheckboxGrpValueController?.value;
  set produceCheckboxGrpValues(List<String>? v) =>
      produceCheckboxGrpValueController?.value = v;

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
