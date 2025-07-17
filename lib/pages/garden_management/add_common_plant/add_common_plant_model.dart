import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'add_common_plant_widget.dart' show AddCommonPlantWidget;
import 'package:flutter/material.dart';

class AddCommonPlantModel extends FlutterFlowModel<AddCommonPlantWidget> {
  ///  Local state fields for this page.

  String? recentlyClickedSpecies;

  bool speciesSelectedBool = false;

  bool showAllSpecies = true;

  bool saveLoading = false;

  int currIncrement = 1;

  String? nickname;

  int currTwins = 1;

  bool noResults = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Validate Form] action in FloatingActionButton widget.
  bool? formValidated;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  GardensRecord? selectedGardenDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  int? numMatchingPlantIDs;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  CommonPlantsRecord? speciesDoc;
  // Stores action output result for [Backend Call - Create Document] action in FloatingActionButton widget.
  PlantsRecord? plantUnderConstruction;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  int? numMatchingSpecies;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  int? moreTwins;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  int? stillTwins;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  List<CommonPlantsRecord> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
