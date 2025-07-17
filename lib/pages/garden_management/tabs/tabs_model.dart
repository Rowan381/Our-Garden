import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'tabs_widget.dart' show TabsWidget;
import 'package:flutter/material.dart';

class TabsModel extends FlutterFlowModel<TabsWidget> {
  ///  Local state fields for this page.

  bool showAllGardens = true;

  bool showAllPlants = true;

  List<String> displayPlantTasksGarden = [];
  void addToDisplayPlantTasksGarden(String item) =>
      displayPlantTasksGarden.add(item);
  void removeFromDisplayPlantTasksGarden(String item) =>
      displayPlantTasksGarden.remove(item);
  void removeAtIndexFromDisplayPlantTasksGarden(int index) =>
      displayPlantTasksGarden.removeAt(index);
  void insertAtIndexInDisplayPlantTasksGarden(int index, String item) =>
      displayPlantTasksGarden.insert(index, item);
  void updateDisplayPlantTasksGardenAtIndex(
          int index, Function(String) updateFn) =>
      displayPlantTasksGarden[index] = updateFn(displayPlantTasksGarden[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Tabs widget.
  List<GardensRecord>? userGardens;
  // Stores action output result for [Firestore Query - Query a collection] action in Tabs widget.
  List<PlantTasksRecord>? todayPlantTasks;
  // Stores action output result for [Firestore Query - Query a collection] action in Tabs widget.
  List<GardenTasksRecord>? todayGardenTasks;
  // State field(s) for TabBar widget.
  TabController? tabBarController1;
  int get tabBarCurrentIndex1 =>
      tabBarController1 != null ? tabBarController1!.index : 0;
  int get tabBarPreviousIndex1 =>
      tabBarController1 != null ? tabBarController1!.previousIndex : 0;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  List<GardensRecord> simpleSearchResults1 = [];
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

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  List<PlantsRecord> simpleSearchResults2 = [];
  // State field(s) for TabBar widget.
  TabController? tabBarController2;
  int get tabBarCurrentIndex2 =>
      tabBarController2 != null ? tabBarController2!.index : 0;
  int get tabBarPreviousIndex2 =>
      tabBarController2 != null ? tabBarController2!.previousIndex : 0;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  List<GardensRecord> simpleSearchResults3 = [];
  // State field(s) for Checkbox widget.
  Map<GardenTasksRecord, bool> checkboxValueMap3 = {};
  List<GardenTasksRecord> get checkboxCheckedItems3 => checkboxValueMap3.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  // State field(s) for Checkbox widget.
  Map<PlantTasksRecord, bool> checkboxValueMap4 = {};
  List<PlantTasksRecord> get checkboxCheckedItems4 => checkboxValueMap4.entries
      .where((e) => e.value)
      .map((e) => e.key)
      .toList();

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  List<PlantsRecord> simpleSearchResults4 = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController1?.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    tabBarController2?.dispose();
    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();
  }
}
