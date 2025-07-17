import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/marketplace/marketplace_assets/listing/listing_widget.dart';
import '/index.dart';
import 'search_listings_widget.dart' show SearchListingsWidget;
import 'package:flutter/material.dart';

class SearchListingsModel extends FlutterFlowModel<SearchListingsWidget> {
  ///  Local state fields for this page.

  bool isShowFullList = true;

  bool productDistanceWorks = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in SearchListings widget.
  List<ProductRecord>? temp;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<ProductRecord> simpleSearchResults = [];
  // State field(s) for Slider widget.
  double? sliderValue;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels1;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels2;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels3;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels4;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels5;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels6;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels7;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels8;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels9;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels10;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels11;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels12;

  @override
  void initState(BuildContext context) {
    listingModels1 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels2 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels3 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels4 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels5 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels6 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels7 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels8 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels9 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels10 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels11 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels12 = FlutterFlowDynamicModels(() => ListingModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    listingModels1.dispose();
    listingModels2.dispose();
    listingModels3.dispose();
    listingModels4.dispose();
    listingModels5.dispose();
    listingModels6.dispose();
    listingModels7.dispose();
    listingModels8.dispose();
    listingModels9.dispose();
    listingModels10.dispose();
    listingModels11.dispose();
    listingModels12.dispose();
  }
}
