import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'add_custom_plant_widget.dart' show AddCustomPlantWidget;
import 'package:flutter/material.dart';

class AddCustomPlantModel extends FlutterFlowModel<AddCustomPlantWidget> {
  ///  Local state fields for this page.

  bool similarSpeciesNotif = false;

  bool speciesNameOnly = true;

  bool saveLoading = false;

  String? nickname;

  int currIncrement = 2;

  int currTwins = 1;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in addCustomPlant widget.
  List<CustomSpeciesRecord>? customSpeciesList;
  // Stores action output result for [Validate Form] action in FloatingActionButton widget.
  bool? formValidated;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  GardensRecord? gardenSelectedDoc;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  List<PlantsRecord>? planTwins;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  List<CommonPlantsRecord>? commonSpeciesPoss;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  int? speciesTwins1;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  int? moreTwins1;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  int? stillTwins1;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  int? speciesTwins2;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  int? moreTwins2;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  int? stillTwins2;
  // Stores action output result for [Backend Call - Create Document] action in FloatingActionButton widget.
  PlantsRecord? plantInProgress;
  // Stores action output result for [Firestore Query - Query a collection] action in FloatingActionButton widget.
  CustomSpeciesRecord? userSpeciesDoc;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for Switch widget.
  bool? switchValue;
  // State field(s) for addedSpeciesDD widget.
  String? addedSpeciesDDValue;
  FormFieldController<String>? addedSpeciesDDValueController;
  // State field(s) for customSpecies widget.
  FocusNode? customSpeciesFocusNode;
  TextEditingController? customSpeciesTextController;
  String? Function(BuildContext, String?)? customSpeciesTextControllerValidator;
  // State field(s) for nickname widget.
  FocusNode? nicknameFocusNode;
  TextEditingController? nicknameTextController;
  String? Function(BuildContext, String?)? nicknameTextControllerValidator;
  bool isDataUploading_uploadDataP0f = false;
  FFUploadedFile uploadedLocalFile_uploadDataP0f =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadDataP0f = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    customSpeciesFocusNode?.dispose();
    customSpeciesTextController?.dispose();

    nicknameFocusNode?.dispose();
    nicknameTextController?.dispose();
  }
}
