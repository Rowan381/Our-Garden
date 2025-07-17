import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/marketplace/marketplace_assets/listing/listing_widget.dart';
import '/index.dart';
import 'search_listings_copy_widget.dart' show SearchListingsCopyWidget;
import 'package:flutter/material.dart';

class SearchListingsCopyModel
    extends FlutterFlowModel<SearchListingsCopyWidget> {
  ///  Local state fields for this page.

  bool isShowFullList = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in SearchListingsCopy widget.
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

  @override
  void initState(BuildContext context) {
    listingModels1 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels2 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels3 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels4 = FlutterFlowDynamicModels(() => ListingModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    listingModels1.dispose();
    listingModels2.dispose();
    listingModels3.dispose();
    listingModels4.dispose();
  }
}
