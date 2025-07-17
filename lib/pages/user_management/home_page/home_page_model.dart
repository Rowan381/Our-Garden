import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> users = [];
  void addToUsers(DocumentReference item) => users.add(item);
  void removeFromUsers(DocumentReference item) => users.remove(item);
  void removeAtIndexFromUsers(int index) => users.removeAt(index);
  void insertAtIndexInUsers(int index, DocumentReference item) =>
      users.insert(index, item);
  void updateUsersAtIndex(int index, Function(DocumentReference) updateFn) =>
      users[index] = updateFn(users[index]);

  int lenGardensToUpdate = -1;

  int lenPlantsToUpdate = -1;

  String linkToApp =
      'https://apps.apple.com/us/app/ourgarden-grow-sell-locally/id6504259412';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  int? ffIsVeryStupid;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  OrdersRecord? pendingOrder;
  // Stores action output result for [Backend Call - Read Document] action in HomePage widget.
  UsersRecord? sellerAccountLoad;
  // Stores action output result for [Backend Call - API (retrieveSession)] action in HomePage widget.
  ApiCallResponse? retrievedSessionLoad;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  ChatsRecord? pendingOrderChat;
  // Stores action output result for [Backend Call - API (Sessions)] action in HomePage widget.
  ApiCallResponse? paymentResult;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  UsersRecord? userDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  List<GardenTasksRecord>? userGardenTasks;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  List<PlantTasksRecord>? userPlantTasks;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  List<GardenTasksRecord>? updateCompleteGarden;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  List<PlantTasksRecord>? updateCompletePlant;
  // Stores action output result for [Backend Call - Create Document] action in Icon widget.
  ChatsRecord? newListingChatThread2;
  // Stores action output result for [Backend Call - Create Document] action in Icon widget.
  ChatsRecord? newListingChatThread3;
  // State field(s) for Checkbox widget.
  Map<GardenTasksRecord, bool> checkboxValueMap1 = {};
  List<GardenTasksRecord> get checkboxCheckedItems1 => checkboxValueMap1.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  // State field(s) for Checkbox widget.
  Map<PlantTasksRecord, bool> checkboxValueMap2 = {};
  List<PlantTasksRecord> get checkboxCheckedItems2 => checkboxValueMap2.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
