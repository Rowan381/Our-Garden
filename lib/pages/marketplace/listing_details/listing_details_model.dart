import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'listing_details_widget.dart' show ListingDetailsWidget;
import 'package:flutter/material.dart';

class ListingDetailsModel extends FlutterFlowModel<ListingDetailsWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> users = [];
  void addToUsers(DocumentReference item) => users.add(item);
  void removeFromUsers(DocumentReference item) => users.remove(item);
  void removeAtIndexFromUsers(int index) => users.removeAt(index);
  void insertAtIndexInUsers(int index, DocumentReference item) =>
      users.insert(index, item);
  void updateUsersAtIndex(int index, Function(DocumentReference) updateFn) =>
      users[index] = updateFn(users[index]);

  int? basketCount;

  bool searchActive = false;

  int index = 0;

  bool reviewsEnabled = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  PendingBasketRecord? testSearch;
  // State field(s) for CountController widget.
  int? countControllerValue;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatsRecord? newListingChatThread2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
