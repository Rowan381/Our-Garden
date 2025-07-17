import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'delete_garden_widget.dart' show DeleteGardenWidget;
import 'package:flutter/material.dart';

class DeleteGardenModel extends FlutterFlowModel<DeleteGardenWidget> {
  ///  Local state fields for this component.

  int? plantsListLen;

  int? currPlantTasksListLen;

  int? gardenTasksListLen;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in deleteGarden widget.
  List<GardenTasksRecord>? gardenTasksList;
  // Stores action output result for [Firestore Query - Query a collection] action in deleteGarden widget.
  List<PlantsRecord>? plantsList;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  List<PlantTasksRecord>? currPlantTasksList;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
