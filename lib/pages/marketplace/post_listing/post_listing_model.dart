import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'post_listing_widget.dart' show PostListingWidget;
import 'package:flutter/material.dart';

class PostListingModel extends FlutterFlowModel<PostListingWidget> {
  ///  Local state fields for this page.

  bool filtersEnabled = false;

  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadDataDos = false;
  FFUploadedFile uploadedLocalFile_uploadDataDos =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataDos = '';

  // State field(s) for categoryChips widget.
  FormFieldController<List<String>>? categoryChipsValueController;
  String? get categoryChipsValue =>
      categoryChipsValueController?.value?.firstOrNull;
  set categoryChipsValue(String? val) =>
      categoryChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for TitleInput widget.
  FocusNode? titleInputFocusNode;
  TextEditingController? titleInputTextController;
  String? Function(BuildContext, String?)? titleInputTextControllerValidator;
  // State field(s) for PriceInput widget.
  FocusNode? priceInputFocusNode;
  TextEditingController? priceInputTextController;
  String? Function(BuildContext, String?)? priceInputTextControllerValidator;
  // State field(s) for UnitInput widget.
  FocusNode? unitInputFocusNode;
  TextEditingController? unitInputTextController;
  String? Function(BuildContext, String?)? unitInputTextControllerValidator;
  // State field(s) for UnitTypeInput widget.
  FocusNode? unitTypeInputFocusNode;
  TextEditingController? unitTypeInputTextController;
  String? Function(BuildContext, String?)? unitTypeInputTextControllerValidator;
  // State field(s) for itemFormDropdown widget.
  String? itemFormDropdownValue;
  FormFieldController<String>? itemFormDropdownValueController;
  // State field(s) for tempConditionDropdown widget.
  String? tempConditionDropdownValue;
  FormFieldController<String>? tempConditionDropdownValueController;
  // State field(s) for DescInput widget.
  FocusNode? descInputFocusNode1;
  TextEditingController? descInputTextController1;
  String? Function(BuildContext, String?)? descInputTextController1Validator;
  // State field(s) for DescInput widget.
  FocusNode? descInputFocusNode2;
  TextEditingController? descInputTextController2;
  String? Function(BuildContext, String?)? descInputTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    titleInputFocusNode?.dispose();
    titleInputTextController?.dispose();

    priceInputFocusNode?.dispose();
    priceInputTextController?.dispose();

    unitInputFocusNode?.dispose();
    unitInputTextController?.dispose();

    unitTypeInputFocusNode?.dispose();
    unitTypeInputTextController?.dispose();

    descInputFocusNode1?.dispose();
    descInputTextController1?.dispose();

    descInputFocusNode2?.dispose();
    descInputTextController2?.dispose();
  }
}
