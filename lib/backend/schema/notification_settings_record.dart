import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationSettingsRecord extends FirestoreRecord {
  NotificationSettingsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "allNotifications" field.
  bool? _allNotifications;
  bool get allNotifications => _allNotifications ?? false;
  bool hasAllNotifications() => _allNotifications != null;

  // "messages" field.
  bool? _messages;
  bool get messages => _messages ?? false;
  bool hasMessages() => _messages != null;

  // "sellerApprovedRequests" field.
  bool? _sellerApprovedRequests;
  bool get sellerApprovedRequests => _sellerApprovedRequests ?? false;
  bool hasSellerApprovedRequests() => _sellerApprovedRequests != null;

  // "priceChanges" field.
  bool? _priceChanges;
  bool get priceChanges => _priceChanges ?? false;
  bool hasPriceChanges() => _priceChanges != null;

  // "newLocalListing" field.
  bool? _newLocalListing;
  bool get newLocalListing => _newLocalListing ?? false;
  bool hasNewLocalListing() => _newLocalListing != null;

  // "newReview" field.
  bool? _newReview;
  bool get newReview => _newReview ?? false;
  bool hasNewReview() => _newReview != null;

  // "lowInventory" field.
  bool? _lowInventory;
  bool get lowInventory => _lowInventory ?? false;
  bool hasLowInventory() => _lowInventory != null;

  // "incomingRequest" field.
  bool? _incomingRequest;
  bool get incomingRequest => _incomingRequest ?? false;
  bool hasIncomingRequest() => _incomingRequest != null;

  // "someoneFavorited" field.
  bool? _someoneFavorited;
  bool get someoneFavorited => _someoneFavorited ?? false;
  bool hasSomeoneFavorited() => _someoneFavorited != null;

  void _initializeFields() {
    _allNotifications = snapshotData['allNotifications'] as bool?;
    _messages = snapshotData['messages'] as bool?;
    _sellerApprovedRequests = snapshotData['sellerApprovedRequests'] as bool?;
    _priceChanges = snapshotData['priceChanges'] as bool?;
    _newLocalListing = snapshotData['newLocalListing'] as bool?;
    _newReview = snapshotData['newReview'] as bool?;
    _lowInventory = snapshotData['lowInventory'] as bool?;
    _incomingRequest = snapshotData['incomingRequest'] as bool?;
    _someoneFavorited = snapshotData['someoneFavorited'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('notificationSettings');

  static Stream<NotificationSettingsRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map((s) => NotificationSettingsRecord.fromSnapshot(s));

  static Future<NotificationSettingsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => NotificationSettingsRecord.fromSnapshot(s));

  static NotificationSettingsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificationSettingsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificationSettingsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificationSettingsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificationSettingsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificationSettingsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificationSettingsRecordData({
  bool? allNotifications,
  bool? messages,
  bool? sellerApprovedRequests,
  bool? priceChanges,
  bool? newLocalListing,
  bool? newReview,
  bool? lowInventory,
  bool? incomingRequest,
  bool? someoneFavorited,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'allNotifications': allNotifications,
      'messages': messages,
      'sellerApprovedRequests': sellerApprovedRequests,
      'priceChanges': priceChanges,
      'newLocalListing': newLocalListing,
      'newReview': newReview,
      'lowInventory': lowInventory,
      'incomingRequest': incomingRequest,
      'someoneFavorited': someoneFavorited,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotificationSettingsRecordDocumentEquality
    implements Equality<NotificationSettingsRecord> {
  const NotificationSettingsRecordDocumentEquality();

  @override
  bool equals(NotificationSettingsRecord? e1, NotificationSettingsRecord? e2) {
    return e1?.allNotifications == e2?.allNotifications &&
        e1?.messages == e2?.messages &&
        e1?.sellerApprovedRequests == e2?.sellerApprovedRequests &&
        e1?.priceChanges == e2?.priceChanges &&
        e1?.newLocalListing == e2?.newLocalListing &&
        e1?.newReview == e2?.newReview &&
        e1?.lowInventory == e2?.lowInventory &&
        e1?.incomingRequest == e2?.incomingRequest &&
        e1?.someoneFavorited == e2?.someoneFavorited;
  }

  @override
  int hash(NotificationSettingsRecord? e) => const ListEquality().hash([
        e?.allNotifications,
        e?.messages,
        e?.sellerApprovedRequests,
        e?.priceChanges,
        e?.newLocalListing,
        e?.newReview,
        e?.lowInventory,
        e?.incomingRequest,
        e?.someoneFavorited
      ]);

  @override
  bool isValidKey(Object? o) => o is NotificationSettingsRecord;
}
