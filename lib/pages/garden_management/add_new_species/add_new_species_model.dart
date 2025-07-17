import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_new_species_widget.dart' show AddNewSpeciesWidget;
import 'package:flutter/material.dart';

class AddNewSpeciesModel extends FlutterFlowModel<AddNewSpeciesWidget> {
  ///  Local state fields for this page.

  bool saveLoading = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Validate Form] action in FloatingActionButton widget.
  bool? valid;
  // State field(s) for nameField widget.
  FocusNode? nameFieldFocusNode1;
  TextEditingController? nameFieldTextController1;
  String? Function(BuildContext, String?)? nameFieldTextController1Validator;
  // State field(s) for nameField widget.
  FocusNode? nameFieldFocusNode2;
  TextEditingController? nameFieldTextController2;
  String? Function(BuildContext, String?)? nameFieldTextController2Validator;
  bool isDataUploading_uploadData17y = false;
  FFUploadedFile uploadedLocalFile_uploadData17y =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData17y = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFieldFocusNode1?.dispose();
    nameFieldTextController1?.dispose();

    nameFieldFocusNode2?.dispose();
    nameFieldTextController2?.dispose();
  }
}
