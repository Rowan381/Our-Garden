import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'order_item_widget.dart' show OrderItemWidget;
import 'package:flutter/material.dart';

class OrderItemModel extends FlutterFlowModel<OrderItemWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in orderItem widget.
  OrdersRecord? currOrder;
  // Stores action output result for [Backend Call - API (retrieveSession)] action in orderItem widget.
  ApiCallResponse? retrievedSessionLoad;
  // Stores action output result for [Firestore Query - Query a collection] action in orderItem widget.
  ChatsRecord? pendingOrderChat;
  // Stores action output result for [Backend Call - Read Document] action in IconButton widget.
  UsersRecord? sellerDoc;
  // Stores action output result for [Backend Call - Read Document] action in IconButton widget.
  UsersRecord? buyerDoc;
  bool isDataUploading_dropOffPic = false;
  FFUploadedFile uploadedLocalFile_dropOffPic =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_dropOffPic = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
