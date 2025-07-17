import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'feedback_page_widget.dart' show FeedbackPageWidget;
import 'package:flutter/material.dart';

class FeedbackPageModel extends FlutterFlowModel<FeedbackPageWidget> {
  ///  Local state fields for this page.

  bool? like;

  String likeColor = '#000000';

  String dislikeColor = '#000000';

  ///  State fields for stateful widgets in this page.

  // State field(s) for reviewTextField widget.
  FocusNode? reviewTextFieldFocusNode;
  TextEditingController? reviewTextFieldTextController;
  String? Function(BuildContext, String?)?
      reviewTextFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    reviewTextFieldFocusNode?.dispose();
    reviewTextFieldTextController?.dispose();
  }
}
