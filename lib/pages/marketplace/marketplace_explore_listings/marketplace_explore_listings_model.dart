import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/marketplace/marketplace_assets/listing/listing_widget.dart';
import '/pages/marketplace/marketplace_assets/listing_large/listing_large_widget.dart';
import '/index.dart';
import 'marketplace_explore_listings_widget.dart'
    show MarketplaceExploreListingsWidget;
import 'package:flutter/material.dart';

class MarketplaceExploreListingsModel
    extends FlutterFlowModel<MarketplaceExploreListingsWidget> {
  ///  Local state fields for this page.

  bool formatSplit = true;

  String linkToApp =
      'https://apps.apple.com/us/app/ourgarden-grow-sell-locally/id6504259412';

  bool enoughListingsToFilterByLoc = false;

  bool filtersImplementedHere = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in MarketplaceExploreListings widget.
  List<ProductRecord>? tempNotMine;
  // Stores action output result for [Firestore Query - Query a collection] action in MarketplaceExploreListings widget.
  List<ProductRecord>? tempMine;
  // Stores action output result for [Backend Call - API (retrieveAccountInfo)] action in MarketplaceExploreListings widget.
  ApiCallResponse? stripeRetrieveOnLoad;
  // Stores action output result for [Backend Call - API (retrieveAccountInfo)] action in Button widget.
  ApiCallResponse? stripeRetrieveAccountInfo;
  // Stores action output result for [Backend Call - API (createAccountLink)] action in Button widget.
  ApiCallResponse? stripeCreateAccountLink2;
  // Stores action output result for [Backend Call - API (retrieveAccountInfo)] action in Button widget.
  ApiCallResponse? stripeRetrieveAccountInfo2;
  // Stores action output result for [Backend Call - API (Accounts)] action in Button widget.
  ApiCallResponse? createStripeAccount;
  // Stores action output result for [Backend Call - API (createAccountLink)] action in Button widget.
  ApiCallResponse? stripeCreateAccountLink;
  // Stores action output result for [Backend Call - API (retrieveAccountInfo)] action in Button widget.
  ApiCallResponse? stripeRetrieveAccountInfo3;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for TabBar widget.
  TabController? tabBarController1;
  int get tabBarCurrentIndex1 =>
      tabBarController1 != null ? tabBarController1!.index : 0;
  int get tabBarPreviousIndex1 =>
      tabBarController1 != null ? tabBarController1!.previousIndex : 0;

  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels1;
  // Models for ListingLarge dynamic component.
  late FlutterFlowDynamicModels<ListingLargeModel> listingLargeModels1;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels2;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels3;
  // Models for ListingLarge dynamic component.
  late FlutterFlowDynamicModels<ListingLargeModel> listingLargeModels2;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels4;
  // Models for ListingLarge dynamic component.
  late FlutterFlowDynamicModels<ListingLargeModel> listingLargeModels3;
  // State field(s) for TabBar widget.
  TabController? tabBarController2;
  int get tabBarCurrentIndex2 =>
      tabBarController2 != null ? tabBarController2!.index : 0;
  int get tabBarPreviousIndex2 =>
      tabBarController2 != null ? tabBarController2!.previousIndex : 0;

  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels5;
  // Models for Listing dynamic component.
  late FlutterFlowDynamicModels<ListingModel> listingModels6;

  @override
  void initState(BuildContext context) {
    listingModels1 = FlutterFlowDynamicModels(() => ListingModel());
    listingLargeModels1 = FlutterFlowDynamicModels(() => ListingLargeModel());
    listingModels2 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels3 = FlutterFlowDynamicModels(() => ListingModel());
    listingLargeModels2 = FlutterFlowDynamicModels(() => ListingLargeModel());
    listingModels4 = FlutterFlowDynamicModels(() => ListingModel());
    listingLargeModels3 = FlutterFlowDynamicModels(() => ListingLargeModel());
    listingModels5 = FlutterFlowDynamicModels(() => ListingModel());
    listingModels6 = FlutterFlowDynamicModels(() => ListingModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    tabBarController1?.dispose();
    listingModels1.dispose();
    listingLargeModels1.dispose();
    listingModels2.dispose();
    listingModels3.dispose();
    listingLargeModels2.dispose();
    listingModels4.dispose();
    listingLargeModels3.dispose();
    tabBarController2?.dispose();
    listingModels5.dispose();
    listingModels6.dispose();
  }
}
