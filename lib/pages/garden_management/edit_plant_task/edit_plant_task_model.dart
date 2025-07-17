import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'edit_plant_task_widget.dart' show EditPlantTaskWidget;
import 'package:flutter/material.dart';

class EditPlantTaskModel extends FlutterFlowModel<EditPlantTaskWidget> {
  ///  Local state fields for this page.

  bool saveLoading = false;

  List<PlantsRecord> currCorrPlants = [];
  void addToCurrCorrPlants(PlantsRecord item) => currCorrPlants.add(item);
  void removeFromCurrCorrPlants(PlantsRecord item) =>
      currCorrPlants.remove(item);
  void removeAtIndexFromCurrCorrPlants(int index) =>
      currCorrPlants.removeAt(index);
  void insertAtIndexInCurrCorrPlants(int index, PlantsRecord item) =>
      currCorrPlants.insert(index, item);
  void updateCurrCorrPlantsAtIndex(
          int index, Function(PlantsRecord) updateFn) =>
      currCorrPlants[index] = updateFn(currCorrPlants[index]);

  bool justLoaded = true;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in editPlantTask widget.
  List<PlantsRecord>? ogCorrespondingPlants;
  // State field(s) for chooseGarden widget.
  String? chooseGardenValue;
  FormFieldController<String>? chooseGardenValueController;
  // Stores action output result for [Firestore Query - Query a collection] action in chooseGarden widget.
  GardensRecord? currGardenRef;
  // Stores action output result for [Firestore Query - Query a collection] action in chooseGarden widget.
  List<PlantsRecord>? correspondingPlants;
  // State field(s) for assignPlant widget.
  String? assignPlantValue;
  FormFieldController<String>? assignPlantValueController;
  // State field(s) for selectObjective widget.
  String? selectObjectiveValue;
  FormFieldController<String>? selectObjectiveValueController;
  // State field(s) for customObjective widget.
  FocusNode? customObjectiveFocusNode;
  TextEditingController? customObjectiveTextController;
  String? Function(BuildContext, String?)?
      customObjectiveTextControllerValidator;
  String? _customObjectiveTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for taskNotes widget.
  FocusNode? taskNotesFocusNode;
  TextEditingController? taskNotesTextController;
  String? Function(BuildContext, String?)? taskNotesTextControllerValidator;
  // State field(s) for frequencyNumField widget.
  FocusNode? frequencyNumFieldFocusNode;
  TextEditingController? frequencyNumFieldTextController;
  String? Function(BuildContext, String?)?
      frequencyNumFieldTextControllerValidator;
  String? _frequencyNumFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp('^[1-9]\\d*\$').hasMatch(val)) {
      return 'Input a positive number';
    }
    return null;
  }

  // State field(s) for frequencyTypeDD widget.
  String? frequencyTypeDDValue;
  FormFieldController<String>? frequencyTypeDDValueController;
  DateTime? datePicked;
  // State field(s) for endTaskSwitch widget.
  bool? endTaskSwitchValue;
  // State field(s) for occurrencesField widget.
  FocusNode? occurrencesFieldFocusNode;
  TextEditingController? occurrencesFieldTextController;
  String? Function(BuildContext, String?)?
      occurrencesFieldTextControllerValidator;
  String? _occurrencesFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp('^[1-9]\\d*\$').hasMatch(val)) {
      return 'Input a positive number';
    }
    return null;
  }

  // Stores action output result for [Validate Form] action in Button widget.
  bool? valid;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  PlantsRecord? recentPlantCreatorRef;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  int? objectiveTwins1;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  int? objectiveTwins2;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  GardensRecord? recentGardenCreatorRefCopy;

  @override
  void initState(BuildContext context) {
    customObjectiveTextControllerValidator =
        _customObjectiveTextControllerValidator;
    frequencyNumFieldTextControllerValidator =
        _frequencyNumFieldTextControllerValidator;
    occurrencesFieldTextControllerValidator =
        _occurrencesFieldTextControllerValidator;
  }

  @override
  void dispose() {
    customObjectiveFocusNode?.dispose();
    customObjectiveTextController?.dispose();

    taskNotesFocusNode?.dispose();
    taskNotesTextController?.dispose();

    frequencyNumFieldFocusNode?.dispose();
    frequencyNumFieldTextController?.dispose();

    occurrencesFieldFocusNode?.dispose();
    occurrencesFieldTextController?.dispose();
  }
}
