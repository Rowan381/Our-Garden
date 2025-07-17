import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'edit_plant_widget.dart' show EditPlantWidget;
import 'package:flutter/material.dart';

class EditPlantModel extends FlutterFlowModel<EditPlantWidget> {
  ///  Local state fields for this page.

  bool saveLoading = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  bool isDataUploading_uploadDataNj8 = false;
  FFUploadedFile uploadedLocalFile_uploadDataNj8 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataNj8 = '';

  // State field(s) for plantIDField widget.
  FocusNode? plantIDFieldFocusNode;
  TextEditingController? plantIDFieldTextController;
  String? Function(BuildContext, String?)? plantIDFieldTextControllerValidator;
  // Stores action output result for [Validate Form] action in Button widget.
  bool? valid;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  GardensRecord? gardenSelectedDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  int? plantTwins;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    plantIDFieldFocusNode?.dispose();
    plantIDFieldTextController?.dispose();
  }
}
