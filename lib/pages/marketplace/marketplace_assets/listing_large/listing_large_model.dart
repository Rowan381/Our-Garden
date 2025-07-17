import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'listing_large_widget.dart' show ListingLargeWidget;
import 'package:flutter/material.dart';

class ListingLargeModel extends FlutterFlowModel<ListingLargeWidget> {
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
