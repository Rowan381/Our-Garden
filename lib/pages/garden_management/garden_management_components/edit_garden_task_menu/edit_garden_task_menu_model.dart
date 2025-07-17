import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'edit_garden_task_menu_widget.dart' show EditGardenTaskMenuWidget;
import 'package:flutter/material.dart';

class EditGardenTaskMenuModel
    extends FlutterFlowModel<EditGardenTaskMenuWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Firestore Query - Query a collection] action in chooseStartButton widget.
  GardenTasksRecord? chosenGTaskDoc;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
