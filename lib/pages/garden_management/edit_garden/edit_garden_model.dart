import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'edit_garden_widget.dart' show EditGardenWidget;
import 'package:flutter/material.dart';

class EditGardenModel extends FlutterFlowModel<EditGardenWidget> {
  ///  Local state fields for this page.

  bool ogSwitchVal = true;

  bool saveLoading = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
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
  bool isDataUploading_uploadDataGw6 = false;
  FFUploadedFile uploadedLocalFile_uploadDataGw6 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataGw6 = '';

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
  // Stores action output result for [Validate Form] action in Button widget.
  bool? valid;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  int? gardenTwins;

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
