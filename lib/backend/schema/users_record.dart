import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "engaged_with_IDs" field.
  List<DocumentReference>? _engagedWithIDs;
  List<DocumentReference> get engagedWithIDs => _engagedWithIDs ?? const [];
  bool hasEngagedWithIDs() => _engagedWithIDs != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "shortDescription" field.
  String? _shortDescription;
  String get shortDescription => _shortDescription ?? '';
  bool hasShortDescription() => _shortDescription != null;

  // "last_active_time" field.
  DateTime? _lastActiveTime;
  DateTime? get lastActiveTime => _lastActiveTime;
  bool hasLastActiveTime() => _lastActiveTime != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  bool hasRole() => _role != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "state" field.
  String? _state;
  String get state => _state ?? '';
  bool hasState() => _state != null;

  // "firstSignIn" field.
  bool? _firstSignIn;
  bool get firstSignIn => _firstSignIn ?? false;
  bool hasFirstSignIn() => _firstSignIn != null;

  // "tsold" field.
  int? _tsold;
  int get tsold => _tsold ?? 0;
  bool hasTsold() => _tsold != null;

  // "cartSellers" field.
  List<DocumentReference>? _cartSellers;
  List<DocumentReference> get cartSellers => _cartSellers ?? const [];
  bool hasCartSellers() => _cartSellers != null;

  // "notificationSettingsRef" field.
  DocumentReference? _notificationSettingsRef;
  DocumentReference? get notificationSettingsRef => _notificationSettingsRef;
  bool hasNotificationSettingsRef() => _notificationSettingsRef != null;

  // "stripeAccountID" field.
  String? _stripeAccountID;
  String get stripeAccountID => _stripeAccountID ?? '';
  bool hasStripeAccountID() => _stripeAccountID != null;

  // "stripeChargesEnabled" field.
  bool? _stripeChargesEnabled;
  bool get stripeChargesEnabled => _stripeChargesEnabled ?? false;
  bool hasStripeChargesEnabled() => _stripeChargesEnabled != null;

  // "likes" field.
  int? _likes;
  int get likes => _likes ?? 0;
  bool hasLikes() => _likes != null;

  // "likesUsers" field.
  List<DocumentReference>? _likesUsers;
  List<DocumentReference> get likesUsers => _likesUsers ?? const [];
  bool hasLikesUsers() => _likesUsers != null;

  // "stripeAccountSetup" field.
  String? _stripeAccountSetup;
  String get stripeAccountSetup => _stripeAccountSetup ?? '';
  bool hasStripeAccountSetup() => _stripeAccountSetup != null;

  // "ThreadID" field.
  String? _threadID;
  String get threadID => _threadID ?? '';
  bool hasThreadID() => _threadID != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _engagedWithIDs = getDataList(snapshotData['engaged_with_IDs']);
    _city = snapshotData['city'] as String?;
    _location = snapshotData['location'] as LatLng?;
    _shortDescription = snapshotData['shortDescription'] as String?;
    _lastActiveTime = snapshotData['last_active_time'] as DateTime?;
    _role = snapshotData['role'] as String?;
    _title = snapshotData['title'] as String?;
    _state = snapshotData['state'] as String?;
    _firstSignIn = snapshotData['firstSignIn'] as bool?;
    _tsold = castToType<int>(snapshotData['tsold']);
    _cartSellers = getDataList(snapshotData['cartSellers']);
    _notificationSettingsRef =
        snapshotData['notificationSettingsRef'] as DocumentReference?;
    _stripeAccountID = snapshotData['stripeAccountID'] as String?;
    _stripeChargesEnabled = snapshotData['stripeChargesEnabled'] as bool?;
    _likes = castToType<int>(snapshotData['likes']);
    _likesUsers = getDataList(snapshotData['likesUsers']);
    _stripeAccountSetup = snapshotData['stripeAccountSetup'] as String?;
    _threadID = snapshotData['ThreadID'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? city,
  LatLng? location,
  String? shortDescription,
  DateTime? lastActiveTime,
  String? role,
  String? title,
  String? state,
  bool? firstSignIn,
  int? tsold,
  DocumentReference? notificationSettingsRef,
  String? stripeAccountID,
  bool? stripeChargesEnabled,
  int? likes,
  String? stripeAccountSetup,
  String? threadID,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'city': city,
      'location': location,
      'shortDescription': shortDescription,
      'last_active_time': lastActiveTime,
      'role': role,
      'title': title,
      'state': state,
      'firstSignIn': firstSignIn,
      'tsold': tsold,
      'notificationSettingsRef': notificationSettingsRef,
      'stripeAccountID': stripeAccountID,
      'stripeChargesEnabled': stripeChargesEnabled,
      'likes': likes,
      'stripeAccountSetup': stripeAccountSetup,
      'ThreadID': threadID,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        listEquality.equals(e1?.engagedWithIDs, e2?.engagedWithIDs) &&
        e1?.city == e2?.city &&
        e1?.location == e2?.location &&
        e1?.shortDescription == e2?.shortDescription &&
        e1?.lastActiveTime == e2?.lastActiveTime &&
        e1?.role == e2?.role &&
        e1?.title == e2?.title &&
        e1?.state == e2?.state &&
        e1?.firstSignIn == e2?.firstSignIn &&
        e1?.tsold == e2?.tsold &&
        listEquality.equals(e1?.cartSellers, e2?.cartSellers) &&
        e1?.notificationSettingsRef == e2?.notificationSettingsRef &&
        e1?.stripeAccountID == e2?.stripeAccountID &&
        e1?.stripeChargesEnabled == e2?.stripeChargesEnabled &&
        e1?.likes == e2?.likes &&
        listEquality.equals(e1?.likesUsers, e2?.likesUsers) &&
        e1?.stripeAccountSetup == e2?.stripeAccountSetup &&
        e1?.threadID == e2?.threadID;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.engagedWithIDs,
        e?.city,
        e?.location,
        e?.shortDescription,
        e?.lastActiveTime,
        e?.role,
        e?.title,
        e?.state,
        e?.firstSignIn,
        e?.tsold,
        e?.cartSellers,
        e?.notificationSettingsRef,
        e?.stripeAccountID,
        e?.stripeChargesEnabled,
        e?.likes,
        e?.likesUsers,
        e?.stripeAccountSetup,
        e?.threadID
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
