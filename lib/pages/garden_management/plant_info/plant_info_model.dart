import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'plant_info_widget.dart' show PlantInfoWidget;
import 'package:flutter/material.dart';

class PlantInfoModel extends FlutterFlowModel<PlantInfoWidget> {
  ///  Local state fields for this page.

  DocumentReference? plantInfoPlantID;

  List<PlantTasksRecord> todayTasks = [];
  void addToTodayTasks(PlantTasksRecord item) => todayTasks.add(item);
  void removeFromTodayTasks(PlantTasksRecord item) => todayTasks.remove(item);
  void removeAtIndexFromTodayTasks(int index) => todayTasks.removeAt(index);
  void insertAtIndexInTodayTasks(int index, PlantTasksRecord item) =>
      todayTasks.insert(index, item);
  void updateTodayTasksAtIndex(
          int index, Function(PlantTasksRecord) updateFn) =>
      todayTasks[index] = updateFn(todayTasks[index]);

  List<PlantTasksRecord> upcomingTasks = [];
  void addToUpcomingTasks(PlantTasksRecord item) => upcomingTasks.add(item);
  void removeFromUpcomingTasks(PlantTasksRecord item) =>
      upcomingTasks.remove(item);
  void removeAtIndexFromUpcomingTasks(int index) =>
      upcomingTasks.removeAt(index);
  void insertAtIndexInUpcomingTasks(int index, PlantTasksRecord item) =>
      upcomingTasks.insert(index, item);
  void updateUpcomingTasksAtIndex(
          int index, Function(PlantTasksRecord) updateFn) =>
      upcomingTasks[index] = updateFn(upcomingTasks[index]);

  String plantFacts = 'No plant facts added for this custom species.';

  int? plantListLen;

  List<String> plantListDisplay = [];
  void addToPlantListDisplay(String item) => plantListDisplay.add(item);
  void removeFromPlantListDisplay(String item) => plantListDisplay.remove(item);
  void removeAtIndexFromPlantListDisplay(int index) =>
      plantListDisplay.removeAt(index);
  void insertAtIndexInPlantListDisplay(int index, String item) =>
      plantListDisplay.insert(index, item);
  void updatePlantListDisplayAtIndex(int index, Function(String) updateFn) =>
      plantListDisplay[index] = updateFn(plantListDisplay[index]);

  bool ogPlantImage = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in plantInfo widget.
  List<CommonPlantsRecord>? commonList;
  // Stores action output result for [Firestore Query - Query a collection] action in plantInfo widget.
  List<CustomSpeciesRecord>? customList;
  // Stores action output result for [Firestore Query - Query a collection] action in plantInfo widget.
  List<PlantsRecord>? plantsList;
  // Stores action output result for [Backend Call - Read Document] action in plantInfo widget.
  GardensRecord? currGardenDoc;
  // Stores action output result for [Backend Call - Read Document] action in plantInfo widget.
  GardensRecord? ogGardenDoc;
  // State field(s) for plantDropdown widget.
  String? plantDropdownValue;
  FormFieldController<String>? plantDropdownValueController;
  // Stores action output result for [Custom Action - newCustomAction2] action in plantDropdown widget.
  List<String>? plantGardenList;
  // Stores action output result for [Firestore Query - Query a collection] action in plantDropdown widget.
  GardensRecord? selectedGardenDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in plantDropdown widget.
  PlantsRecord? selectedPlantDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in plantDropdown widget.
  List<CommonPlantsRecord>? selectedCommonList;
  // Stores action output result for [Firestore Query - Query a collection] action in plantDropdown widget.
  List<CustomSpeciesRecord>? selectedCustomList;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for Checkbox widget.
  Map<PlantTasksRecord, bool> checkboxValueMap = {};
  List<PlantTasksRecord> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }

  /// Action blocks.
  Future viewTask(BuildContext context) async {}
}
