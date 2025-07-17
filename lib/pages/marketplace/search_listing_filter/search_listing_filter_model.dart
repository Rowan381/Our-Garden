import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'search_listing_filter_widget.dart' show SearchListingFilterWidget;
import 'package:flutter/material.dart';

class SearchListingFilterModel
    extends FlutterFlowModel<SearchListingFilterWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for sortOnDropdown widget.
  String? sortOnDropdownValue;
  FormFieldController<String>? sortOnDropdownValueController;
  // State field(s) for sortTypeDrop widget.
  String? sortTypeDropValue;
  FormFieldController<String>? sortTypeDropValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
