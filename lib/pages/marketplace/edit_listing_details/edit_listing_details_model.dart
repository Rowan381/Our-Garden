import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'edit_listing_details_widget.dart' show EditListingDetailsWidget;
import 'package:flutter/material.dart';

class EditListingDetailsModel
    extends FlutterFlowModel<EditListingDetailsWidget> {
  ///  Local state fields for this page.

  String imageURLListing =
      'https://cdn.atwilltech.com/flowerdatabase/s/snake-plant-house-plant-PL112722.425.jpg';

  bool filtersEnabled = false;

  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadDataDos2 = false;
  FFUploadedFile uploadedLocalFile_uploadDataDos2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataDos2 = '';

  // State field(s) for TitleInput widget.
  FocusNode? titleInputFocusNode;
  TextEditingController? titleInputTextController;
  String? Function(BuildContext, String?)? titleInputTextControllerValidator;
  // State field(s) for UnitTypeInput widget.
  FocusNode? unitTypeInputFocusNode;
  TextEditingController? unitTypeInputTextController;
  String? Function(BuildContext, String?)? unitTypeInputTextControllerValidator;
  // State field(s) for UnitInput widget.
  FocusNode? unitInputFocusNode;
  TextEditingController? unitInputTextController;
  String? Function(BuildContext, String?)? unitInputTextControllerValidator;
  // State field(s) for PriceInput widget.
  FocusNode? priceInputFocusNode;
  TextEditingController? priceInputTextController;
  String? Function(BuildContext, String?)? priceInputTextControllerValidator;
  // State field(s) for DescInput widget.
  FocusNode? descInputFocusNode;
  TextEditingController? descInputTextController;
  String? Function(BuildContext, String?)? descInputTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    titleInputFocusNode?.dispose();
    titleInputTextController?.dispose();

    unitTypeInputFocusNode?.dispose();
    unitTypeInputTextController?.dispose();

    unitInputFocusNode?.dispose();
    unitInputTextController?.dispose();

    priceInputFocusNode?.dispose();
    priceInputTextController?.dispose();

    descInputFocusNode?.dispose();
    descInputTextController?.dispose();
  }
}
