import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'chat2_invite_users_widget.dart' show Chat2InviteUsersWidget;
import 'package:flutter/material.dart';
import 'dart:async';

class Chat2InviteUsersModel extends FlutterFlowModel<Chat2InviteUsersWidget> {
  ///  Local state fields for this page.

  List<DocumentReference> friendsList = [];
  void addToFriendsList(DocumentReference item) => friendsList.add(item);
  void removeFromFriendsList(DocumentReference item) =>
      friendsList.remove(item);
  void removeAtIndexFromFriendsList(int index) => friendsList.removeAt(index);
  void insertAtIndexInFriendsList(int index, DocumentReference item) =>
      friendsList.insert(index, item);
  void updateFriendsListAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      friendsList[index] = updateFn(friendsList[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for ListView widget.
  Query? listViewQuery;
  List<StreamSubscription?> listViewStreamSubscriptions = [];

  // Current page of users
  List<UsersRecord> users = [];
  bool isLoading = false;
  bool hasMoreData = true;
  DocumentSnapshot? lastDocument;

  // Page size for fetching users
  final int pageSize = 16;

  // State field(s) for CheckboxListTile widget.
  Map<UsersRecord, bool> checkboxListTileValueMap = {};
  List<UsersRecord> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  ChatsRecord? updatedChatThread;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatsRecord? newChatThread;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    listViewStreamSubscriptions.forEach((s) => s?.cancel());
  }

  /// Additional helper methods.

  // Initialize users with a query
  Future<void> initializeUsers(Query query) async {
    listViewQuery = query;
    await loadInitialUsers();
  }

  // Load the first page of users
  Future<void> loadInitialUsers() async {
    if (isLoading || listViewQuery == null) return;

    isLoading = true;
    users = [];
    lastDocument = null;
    hasMoreData = true;

    try {
      final snapshot = await queryUsersRecordOnce(
        queryBuilder: (_) => listViewQuery!,
        limit: pageSize,
      );

      users = snapshot;
      hasMoreData = snapshot.length == pageSize;

      // Save the last document for pagination
      if (snapshot.isNotEmpty) {
        // Get the actual DocumentSnapshot from Firestore
        lastDocument = await listViewQuery!
            .limit(pageSize)
            .get()
            .then((value) => value.docs.isNotEmpty ? value.docs.last : null);
      }

      // Update the checkboxes map with new users
      for (var user in users) {
        if (!checkboxListTileValueMap.containsKey(user)) {
          checkboxListTileValueMap[user] = false;
        }
      }
    } catch (e) {
      print('Error loading initial users: $e');
    } finally {
      isLoading = false;
    }
  }

  // Load the next page of users
  Future<void> loadMoreUsers() async {
    if (isLoading ||
        !hasMoreData ||
        lastDocument == null ||
        listViewQuery == null) return;

    isLoading = true;

    try {
      // Create a query that starts after the last document
      final nextQuery = listViewQuery!.startAfterDocument(lastDocument!);

      final snapshot = await queryUsersRecordOnce(
        queryBuilder: (_) => nextQuery,
        limit: pageSize,
      );

      if (snapshot.isEmpty) {
        hasMoreData = false;
      } else {
        users.addAll(snapshot);

        // Get the actual DocumentSnapshot for the next page
        lastDocument = await nextQuery
            .limit(pageSize)
            .get()
            .then((value) => value.docs.isNotEmpty ? value.docs.last : null);

        hasMoreData = snapshot.length == pageSize;

        // Update the checkboxes map with new users
        for (var user in snapshot) {
          if (!checkboxListTileValueMap.containsKey(user)) {
            checkboxListTileValueMap[user] = false;
          }
        }
      }
    } catch (e) {
      print('Error loading more users: $e');
    } finally {
      isLoading = false;
    }
  }

  // Refresh the users list
  Future<void> refreshUsers() async {
    if (listViewQuery == null) return;
    await loadInitialUsers();
  }
}
