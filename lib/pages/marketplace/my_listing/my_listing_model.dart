import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'my_listing_widget.dart' show MyListingWidget;
import 'package:flutter/material.dart';

class MyListingModel extends FlutterFlowModel<MyListingWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
