import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'add_garden_widget.dart' show AddGardenWidget;
import 'package:flutter/material.dart';

class AddGardenModel extends FlutterFlowModel<AddGardenWidget> {
  ///  Local state fields for this page.

  bool saveLoading = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Validate Form] action in FloatingActionButton widget.
  bool? formValidated;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  List<GardensRecord>? gardenTwins;
  // Stores action output result for [Backend Call - Create Document] action in FloatingActionButton widget.
  GardensRecord? gardenInProgress;
  // State field(s) for nameField widget.
  FocusNode? nameFieldFocusNode;
  TextEditingController? nameFieldTextController;
  String? Function(BuildContext, String?)? nameFieldTextControllerValidator;
  String? _nameFieldTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for descriptionField widget.
  FocusNode? descriptionFieldFocusNode;
  TextEditingController? descriptionFieldTextController;
  String? Function(BuildContext, String?)?
      descriptionFieldTextControllerValidator;
  bool isDataUploading_uploadData17y6 = false;
  FFUploadedFile uploadedLocalFile_uploadData17y6 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData17y6 = '';

  // State field(s) for soilTypeDD widget.
  String? soilTypeDDValue;
  FormFieldController<String>? soilTypeDDValueController;
  // State field(s) for lightingDD widget.
  String? lightingDDValue;
  FormFieldController<String>? lightingDDValueController;
  // State field(s) for locationDD widget.
  String? locationDDValue;
  FormFieldController<String>? locationDDValueController;
  // State field(s) for publicSwitch widget.
  bool? publicSwitchValue;

  @override
  void initState(BuildContext context) {
    nameFieldTextControllerValidator = _nameFieldTextControllerValidator;
  }

  @override
  void dispose() {
    nameFieldFocusNode?.dispose();
    nameFieldTextController?.dispose();

    descriptionFieldFocusNode?.dispose();
    descriptionFieldTextController?.dispose();
  }
}
