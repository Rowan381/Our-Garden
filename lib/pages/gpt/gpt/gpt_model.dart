import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'gpt_widget.dart' show GptWidget;
import 'package:flutter/material.dart';

class GptModel extends FlutterFlowModel<GptWidget> {
  ///  Local state fields for this page.

  List<ContentStruct> chatHistory = [];
  void addToChatHistory(ContentStruct item) => chatHistory.add(item);
  void removeFromChatHistory(ContentStruct item) => chatHistory.remove(item);
  void removeAtIndexFromChatHistory(int index) => chatHistory.removeAt(index);
  void insertAtIndexInChatHistory(int index, ContentStruct item) =>
      chatHistory.insert(index, item);
  void updateChatHistoryAtIndex(int index, Function(ContentStruct) updateFn) =>
      chatHistory[index] = updateFn(chatHistory[index]);

  String threadId = 'threadId';

  String runId = 'runId';

  AIsavedChatsRecord? currentChat;

  bool resumeFlag = false;

  List<String> uploadedImages = [];
  void addToUploadedImages(String item) => uploadedImages.add(item);
  void removeFromUploadedImages(String item) => uploadedImages.remove(item);
  void removeAtIndexFromUploadedImages(int index) =>
      uploadedImages.removeAt(index);
  void insertAtIndexInUploadedImages(int index, String item) =>
      uploadedImages.insert(index, item);
  void updateUploadedImagesAtIndex(int index, Function(String) updateFn) =>
      uploadedImages[index] = updateFn(uploadedImages[index]);

  String? openaiMessageContent = '';

  bool systemMessage = false;

  String additionalInstructions = '';

  dynamic apiAssistantRunResultCentral;

  String? inputPrompt;

  String status = 'queued';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (threads)] action in GPT widget.
  ApiCallResponse? apiThreadsResult;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for ListView widget.
  ScrollController? listViewController1;
  // State field(s) for ScollingChatColumn widget.
  ScrollController? scollingChatColumn;
  // State field(s) for ChatListView widget.
  ScrollController? chatListView;
  // State field(s) for ListView widget.
  ScrollController? listViewController2;
  bool isDataUploading_tempImageUpload = false;
  FFUploadedFile uploadedLocalFile_tempImageUpload =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_tempImageUpload = '';

  // Stores action output result for [Alert Dialog - Custom Dialog] action in Container widget.
  String? additionalImage;
  // State field(s) for QuestionTestField widget.
  FocusNode? questionTestFieldFocusNode;
  TextEditingController? questionTestFieldTextController;
  String? Function(BuildContext, String?)?
      questionTestFieldTextControllerValidator;
  // Stores action output result for [Backend Call - API (message)] action in SubmitIconButton widget.
  ApiCallResponse? threadMessageCreation;
  // Stores action output result for [Backend Call - API (run)] action in SubmitIconButton widget.
  ApiCallResponse? assistantrun;
  // Stores action output result for [Backend Call - API (retrieverun)] action in SubmitIconButton widget.
  ApiCallResponse? assistantStatus;
  // Stores action output result for [Backend Call - API (messages)] action in SubmitIconButton widget.
  ApiCallResponse? chatMessagesList;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    listViewController1 = ScrollController();
    scollingChatColumn = ScrollController();
    chatListView = ScrollController();
    listViewController2 = ScrollController();
  }

  @override
  void dispose() {
    columnController?.dispose();
    listViewController1?.dispose();
    scollingChatColumn?.dispose();
    chatListView?.dispose();
    listViewController2?.dispose();
    questionTestFieldFocusNode?.dispose();
    questionTestFieldTextController?.dispose();
  }
}
