import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/chat_groupwbubbles/chat_thread_component/chat_thread_component_widget.dart';
import 'chat2_details_cart_widget.dart' show Chat2DetailsCartWidget;
import 'package:flutter/material.dart';

class Chat2DetailsCartModel extends FlutterFlowModel<Chat2DetailsCartWidget> {
  ///  Local state fields for this page.

  List<String> uploadedImages = [];
  void addToUploadedImages(String item) => uploadedImages.add(item);
  void removeFromUploadedImages(String item) => uploadedImages.remove(item);
  void removeAtIndexFromUploadedImages(int index) =>
      uploadedImages.removeAt(index);
  void insertAtIndexInUploadedImages(int index, String item) =>
      uploadedImages.insert(index, item);
  void updateUploadedImagesAtIndex(int index, Function(String) updateFn) =>
      uploadedImages[index] = updateFn(uploadedImages[index]);

  List<DocumentReference> lastMessageSeenBy = [];
  void addToLastMessageSeenBy(DocumentReference item) =>
      lastMessageSeenBy.add(item);
  void removeFromLastMessageSeenBy(DocumentReference item) =>
      lastMessageSeenBy.remove(item);
  void removeAtIndexFromLastMessageSeenBy(int index) =>
      lastMessageSeenBy.removeAt(index);
  void insertAtIndexInLastMessageSeenBy(int index, DocumentReference item) =>
      lastMessageSeenBy.insert(index, item);
  void updateLastMessageSeenByAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      lastMessageSeenBy[index] = updateFn(lastMessageSeenBy[index]);

  String linkToApp =
      'https://apps.apple.com/us/app/ourgarden-grow-sell-locally/id6504259412';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in chat_2_Details_Cart widget.
  int? chatMessageCount;
  // Stores action output result for [Firestore Query - Query a collection] action in chat_2_Details_Cart widget.
  OrdersRecord? pendingOrder;
  // Stores action output result for [Backend Call - Read Document] action in chat_2_Details_Cart widget.
  UsersRecord? sellerAccountLoad;
  // Stores action output result for [Backend Call - API (retrieveSession)] action in chat_2_Details_Cart widget.
  ApiCallResponse? retrievedSessionLoad;
  // Stores action output result for [Firestore Query - Query a collection] action in chat_2_Details_Cart widget.
  ChatsRecord? pendingOrderChat;
  // Stores action output result for [Backend Call - API (Sessions)] action in chat_2_Details_Cart widget.
  ApiCallResponse? paymentResult;
  // Stores action output result for [Backend Call - Read Document] action in Row-singleUser widget.
  ProductRecord? newProductRef;
  // Model for chat_ThreadComponent component.
  late ChatThreadComponentModel chatThreadComponentModel;

  @override
  void initState(BuildContext context) {
    chatThreadComponentModel =
        createModel(context, () => ChatThreadComponentModel());
  }

  @override
  void dispose() {
    chatThreadComponentModel.dispose();
  }
}
