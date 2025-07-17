import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'delete_plant_widget.dart' show DeletePlantWidget;
import 'package:flutter/material.dart';

class DeletePlantModel extends FlutterFlowModel<DeletePlantWidget> {
  ///  Local state fields for this component.

  int? taskListLen;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in deletePlant widget.
  List<PlantTasksRecord>? taskList;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
