import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'edit_plant_task_menu_widget.dart' show EditPlantTaskMenuWidget;
import 'package:flutter/material.dart';

class EditPlantTaskMenuModel extends FlutterFlowModel<EditPlantTaskMenuWidget> {
  ///  Local state fields for this component.

  int? pTaskListLen;

  List<String> pTaskListDisplay = [];
  void addToPTaskListDisplay(String item) => pTaskListDisplay.add(item);
  void removeFromPTaskListDisplay(String item) => pTaskListDisplay.remove(item);
  void removeAtIndexFromPTaskListDisplay(int index) =>
      pTaskListDisplay.removeAt(index);
  void insertAtIndexInPTaskListDisplay(int index, String item) =>
      pTaskListDisplay.insert(index, item);
  void updatePTaskListDisplayAtIndex(int index, Function(String) updateFn) =>
      pTaskListDisplay[index] = updateFn(pTaskListDisplay[index]);

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Read Document] action in editPlantTaskMenu widget.
  PlantsRecord? currPlantDoc;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - newCustomAction] action in chooseStartButton widget.
  List<String>? nameObjList;
  // Stores action output result for [Firestore Query - Query a collection] action in chooseStartButton widget.
  PlantsRecord? chosenPlantDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in chooseStartButton widget.
  PlantTasksRecord? chosenPTaskDoc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
