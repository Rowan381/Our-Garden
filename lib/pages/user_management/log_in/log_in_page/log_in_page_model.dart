import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'log_in_page_widget.dart' show LogInPageWidget;
import 'package:flutter/material.dart';

class LogInPageModel extends FlutterFlowModel<LogInPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for userFieldLog widget.
  FocusNode? userFieldLogFocusNode;
  TextEditingController? userFieldLogTextController;
  String? Function(BuildContext, String?)? userFieldLogTextControllerValidator;
  // State field(s) for passwordFieldLog widget.
  FocusNode? passwordFieldLogFocusNode;
  TextEditingController? passwordFieldLogTextController;
  late bool passwordFieldLogVisibility;
  String? Function(BuildContext, String?)?
      passwordFieldLogTextControllerValidator;

  @override
  void initState(BuildContext context) {
    passwordFieldLogVisibility = false;
  }

  @override
  void dispose() {
    userFieldLogFocusNode?.dispose();
    userFieldLogTextController?.dispose();

    passwordFieldLogFocusNode?.dispose();
    passwordFieldLogTextController?.dispose();
  }
}
