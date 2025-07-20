import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/backend.dart';
import '/backend/api_requests/api_calls.dart';
import 'models/home_page_data_model.dart';
import 'controllers/home_page_controller.dart';

/// FlutterFlow-compatible model that integrates with our MVC architecture
///
/// This class serves as a bridge between FlutterFlow's model pattern and our
/// custom MVC architecture. It delegates all state management to the MVC
/// data model while maintaining backward compatibility with FlutterFlow widgets.
///
/// Key Features:
/// - Seamless integration with existing FlutterFlow widgets
/// - Proper MVC architecture delegation
/// - Backward compatibility with legacy code
/// - Centralized state management through HomePageDataModel
/// - Complete independence from original widget
class HomePageModel extends FlutterFlowModel<StatefulWidget> {
  // Integrate our MVC data model
  late HomePageDataModel _mvcDataModel;
  HomePageController? _mvcController;

  // Legacy FlutterFlow properties for backward compatibility
  List<DocumentReference> get users => _mvcDataModel.users;
  int get lenGardensToUpdate => _mvcDataModel.lenGardensToUpdate;
  int get lenPlantsToUpdate => _mvcDataModel.lenPlantsToUpdate;
  String get linkToApp => _mvcDataModel.linkToApp;

  // State fields that delegate to MVC data model
  int? ffIsVeryStupid;
  OrdersRecord? get pendingOrder => _mvcDataModel.pendingOrder;
  UsersRecord? get sellerAccountLoad => _mvcDataModel.sellerAccountLoad;
  ApiCallResponse? get retrievedSessionLoad =>
      _mvcDataModel.retrievedSessionLoad;
  ChatsRecord? get pendingOrderChat => _mvcDataModel.pendingOrderChat;
  ApiCallResponse? get paymentResult => _mvcDataModel.paymentResult;
  UsersRecord? get userDoc => _mvcDataModel.userDoc;
  List<GardenTasksRecord>? get userGardenTasks => _mvcDataModel.userGardenTasks;
  List<PlantTasksRecord>? get userPlantTasks => _mvcDataModel.userPlantTasks;
  List<GardenTasksRecord>? get updateCompleteGarden =>
      _mvcDataModel.updateCompleteGarden;
  List<PlantTasksRecord>? get updateCompletePlant =>
      _mvcDataModel.updateCompletePlant;
  Map<GardenTasksRecord, bool> get checkboxValueMap1 =>
      _mvcDataModel.checkboxValueMap1;
  Map<PlantTasksRecord, bool> get checkboxValueMap2 =>
      _mvcDataModel.checkboxValueMap2;

  @override
  void initState(BuildContext context) {
    _mvcDataModel = HomePageDataModel();
    // Initialize the controller with context and data model
    _mvcController = HomePageController(context);
  }

  @override
  void dispose() {
    _mvcController?.dispose();
  }

  // Getters and setters for MVC integration
  HomePageDataModel get mvcDataModel => _mvcDataModel;

  void setMvcController(HomePageController controller) {
    _mvcController = controller;
  }

  HomePageController? get mvcController => _mvcController;

  /// Initialize the MVC architecture and load data
  Future<void> initializeMVC() async {
    if (_mvcController != null) {
      await _mvcController!.initializePage();
    }
  }

  // Legacy methods for backward compatibility
  void addToUsers(DocumentReference item) => _mvcDataModel.addToUsers(item);
  void removeFromUsers(DocumentReference item) =>
      _mvcDataModel.removeFromUsers(item);
  void removeAtIndexFromUsers(int index) =>
      _mvcDataModel.removeAtIndexFromUsers(index);
  void insertAtIndexInUsers(int index, DocumentReference item) =>
      _mvcDataModel.insertAtIndexInUsers(index, item);
  void updateUsersAtIndex(int index, Function(DocumentReference) updateFn) =>
      _mvcDataModel.updateUsersAtIndex(index, updateFn);
}
