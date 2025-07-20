import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Base model for the home page containing all data state
class HomePageDataModel {
  // User-related data
  List<DocumentReference> users = [];
  UsersRecord? userDoc;

  // Garden-related data
  List<GardenTasksRecord>? userGardenTasks;
  List<GardenTasksRecord>? updateCompleteGarden;
  int lenGardensToUpdate = -1;

  // Plant-related data
  List<PlantTasksRecord>? userPlantTasks;
  List<PlantTasksRecord>? updateCompletePlant;
  int lenPlantsToUpdate = -1;

  // Order-related data
  OrdersRecord? pendingOrder;
  UsersRecord? sellerAccountLoad;
  ChatsRecord? pendingOrderChat;

  // Payment-related data
  ApiCallResponse? retrievedSessionLoad;
  ApiCallResponse? paymentResult;

  // App-related data
  int? ffIsVeryStupid;
  String linkToApp =
      'https://apps.apple.com/us/app/ourgarden-grow-sell-locally/id6504259412';

  // Checkbox state for tasks
  Map<GardenTasksRecord, bool> checkboxValueMap1 = {};
  Map<PlantTasksRecord, bool> checkboxValueMap2 = {};

  // Utility methods for users list
  void addToUsers(DocumentReference item) => users.add(item);
  void removeFromUsers(DocumentReference item) => users.remove(item);
  void removeAtIndexFromUsers(int index) => users.removeAt(index);
  void insertAtIndexInUsers(int index, DocumentReference item) =>
      users.insert(index, item);
  void updateUsersAtIndex(int index, Function(DocumentReference) updateFn) =>
      users[index] = updateFn(users[index]);

  // Clear all data
  void clearData() {
    users.clear();
    userDoc = null;
    userGardenTasks = null;
    userPlantTasks = null;
    updateCompleteGarden = null;
    updateCompletePlant = null;
    pendingOrder = null;
    sellerAccountLoad = null;
    pendingOrderChat = null;
    retrievedSessionLoad = null;
    paymentResult = null;
    checkboxValueMap1.clear();
    checkboxValueMap2.clear();
    lenGardensToUpdate = -1;
    lenPlantsToUpdate = -1;
    ffIsVeryStupid = null;
  }
}
