import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'edit_task_menu_widget.dart' show EditTaskMenuWidget;
import 'package:flutter/material.dart';

class EditTaskMenuModel extends FlutterFlowModel<EditTaskMenuWidget> {
  ///  Local state fields for this page.

  DocumentReference? gardenRef;

  List<PlantTasksRecord> currPlantTasks = [];
  void addToCurrPlantTasks(PlantTasksRecord item) => currPlantTasks.add(item);
  void removeFromCurrPlantTasks(PlantTasksRecord item) =>
      currPlantTasks.remove(item);
  void removeAtIndexFromCurrPlantTasks(int index) =>
      currPlantTasks.removeAt(index);
  void insertAtIndexInCurrPlantTasks(int index, PlantTasksRecord item) =>
      currPlantTasks.insert(index, item);
  void updateCurrPlantTasksAtIndex(
          int index, Function(PlantTasksRecord) updateFn) =>
      currPlantTasks[index] = updateFn(currPlantTasks[index]);

  List<GardenTasksRecord> currGardenTasks = [];
  void addToCurrGardenTasks(GardenTasksRecord item) =>
      currGardenTasks.add(item);
  void removeFromCurrGardenTasks(GardenTasksRecord item) =>
      currGardenTasks.remove(item);
  void removeAtIndexFromCurrGardenTasks(int index) =>
      currGardenTasks.removeAt(index);
  void insertAtIndexInCurrGardenTasks(int index, GardenTasksRecord item) =>
      currGardenTasks.insert(index, item);
  void updateCurrGardenTasksAtIndex(
          int index, Function(GardenTasksRecord) updateFn) =>
      currGardenTasks[index] = updateFn(currGardenTasks[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in editTaskMenu widget.
  List<GardenTasksRecord>? ogGardenTasks;
  // Stores action output result for [Firestore Query - Query a collection] action in editTaskMenu widget.
  List<PlantTasksRecord>? ogPlantTasks;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Firestore Query - Query a collection] action in DropDown widget.
  GardensRecord? currGardenDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in DropDown widget.
  List<GardenTasksRecord>? tempGardenTasks;
  // Stores action output result for [Firestore Query - Query a collection] action in DropDown widget.
  List<PlantTasksRecord>? tempPlantTasks;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
