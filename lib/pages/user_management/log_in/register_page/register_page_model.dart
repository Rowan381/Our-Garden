import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'register_page_widget.dart' show RegisterPageWidget;
import 'package:flutter/material.dart';

class RegisterPageModel extends FlutterFlowModel<RegisterPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for userFieldLog widget.
  FocusNode? userFieldLogFocusNode;
  TextEditingController? userFieldLogTextController;
  String? Function(BuildContext, String?)? userFieldLogTextControllerValidator;
  // State field(s) for passwordFieldReg widget.
  FocusNode? passwordFieldRegFocusNode;
  TextEditingController? passwordFieldRegTextController;
  late bool passwordFieldRegVisibility;
  String? Function(BuildContext, String?)?
      passwordFieldRegTextControllerValidator;
  // State field(s) for passwordFieldRegVer widget.
  FocusNode? passwordFieldRegVerFocusNode;
  TextEditingController? passwordFieldRegVerTextController;
  late bool passwordFieldRegVerVisibility;
  String? Function(BuildContext, String?)?
      passwordFieldRegVerTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in googleContainer widget.
  UsersRecord? userDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in applecontainer widget.
  UsersRecord? userDoc1;

  @override
  void initState(BuildContext context) {
    passwordFieldRegVisibility = false;
    passwordFieldRegVerVisibility = false;
  }

  @override
  void dispose() {
    userFieldLogFocusNode?.dispose();
    userFieldLogTextController?.dispose();

    passwordFieldRegFocusNode?.dispose();
    passwordFieldRegTextController?.dispose();

    passwordFieldRegVerFocusNode?.dispose();
    passwordFieldRegVerTextController?.dispose();
  }
}
