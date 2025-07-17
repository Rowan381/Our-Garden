import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'user_profile_widget.dart' show UserProfileWidget;
import 'package:flutter/material.dart';

class UserProfileModel extends FlutterFlowModel<UserProfileWidget> {
  ///  Local state fields for this page.

  bool hasActiveListing = true;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in user_profile widget.
  int? activeUserListings;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
