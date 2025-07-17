import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'edit_profile_page_widget.dart' show EditProfilePageWidget;
import 'package:flutter/material.dart';

class EditProfilePageModel extends FlutterFlowModel<EditProfilePageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  bool isDataUploading_uploadData0yt = false;
  FFUploadedFile uploadedLocalFile_uploadData0yt =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData0yt = '';

  // State field(s) for yourEmail widget.
  FocusNode? yourEmailFocusNode;
  TextEditingController? yourEmailTextController;
  String? Function(BuildContext, String?)? yourEmailTextControllerValidator;
  // State field(s) for yourName widget.
  FocusNode? yourNameFocusNode;
  TextEditingController? yourNameTextController;
  String? Function(BuildContext, String?)? yourNameTextControllerValidator;
  // State field(s) for yourNumber widget.
  FocusNode? yourNumberFocusNode;
  TextEditingController? yourNumberTextController;
  String? Function(BuildContext, String?)? yourNumberTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    yourEmailFocusNode?.dispose();
    yourEmailTextController?.dispose();

    yourNameFocusNode?.dispose();
    yourNameTextController?.dispose();

    yourNumberFocusNode?.dispose();
    yourNumberTextController?.dispose();
  }
}
