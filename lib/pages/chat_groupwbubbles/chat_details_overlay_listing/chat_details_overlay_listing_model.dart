import '/flutter_flow/flutter_flow_util.dart';
import '/pages/chat_groupwbubbles/delete_dialog_listing/delete_dialog_listing_widget.dart';
import '/pages/chat_groupwbubbles/user_list_small/user_list_small_widget.dart';
import 'chat_details_overlay_listing_widget.dart'
    show ChatDetailsOverlayListingWidget;
import 'package:flutter/material.dart';

class ChatDetailsOverlayListingModel
    extends FlutterFlowModel<ChatDetailsOverlayListingWidget> {
  ///  State fields for stateful widgets in this component.

  // Models for user_ListSmall dynamic component.
  late FlutterFlowDynamicModels<UserListSmallModel> userListSmallModels;
  // Model for deleteDialogListing component.
  late DeleteDialogListingModel deleteDialogListingModel;

  @override
  void initState(BuildContext context) {
    userListSmallModels = FlutterFlowDynamicModels(() => UserListSmallModel());
    deleteDialogListingModel =
        createModel(context, () => DeleteDialogListingModel());
  }

  @override
  void dispose() {
    userListSmallModels.dispose();
    deleteDialogListingModel.dispose();
  }
}
