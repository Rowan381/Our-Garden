import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'listing_widget.dart' show ListingWidget;
import 'package:flutter/material.dart';

class ListingModel extends FlutterFlowModel<ListingWidget> {
  ///  Local state fields for this component.

  bool added = false;

  bool notMyListing = false;

  int index = 0;

  bool terminated = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in Container_unadded widget.
  PendingBasketRecord? testSearch;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
