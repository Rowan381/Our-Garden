import '/flutter_flow/flutter_flow_util.dart';
import '/pages/marketplace/marketplace_assets/listing/listing_widget.dart';
import '/index.dart';
import 'archived_listings_widget.dart' show ArchivedListingsWidget;
import 'package:flutter/material.dart';

class ArchivedListingsModel extends FlutterFlowModel<ArchivedListingsWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels;

  @override
  void initState(BuildContext context) {
    listingModels = FlutterFlowDynamicModels(() => ListingModel());
  }

  @override
  void dispose() {
    listingModels.dispose();
  }
}
