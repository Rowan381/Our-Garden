import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatsRecord extends FirestoreRecord {
  ChatsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "last_message" field.
  String? _lastMessage;
  String get lastMessage => _lastMessage ?? '';
  bool hasLastMessage() => _lastMessage != null;

  // "last_message_time" field.
  DateTime? _lastMessageTime;
  DateTime? get lastMessageTime => _lastMessageTime;
  bool hasLastMessageTime() => _lastMessageTime != null;

  // "users" field.
  List<DocumentReference>? _users;
  List<DocumentReference> get users => _users ?? const [];
  bool hasUsers() => _users != null;

  // "participants_ID" field.
  List<DocumentReference>? _participantsID;
  List<DocumentReference> get participantsID => _participantsID ?? const [];
  bool hasParticipantsID() => _participantsID != null;

  // "participants_names" field.
  List<String>? _participantsNames;
  List<String> get participantsNames => _participantsNames ?? const [];
  bool hasParticipantsNames() => _participantsNames != null;

  // "participants_images" field.
  List<String>? _participantsImages;
  List<String> get participantsImages => _participantsImages ?? const [];
  bool hasParticipantsImages() => _participantsImages != null;

  // "user_a" field.
  DocumentReference? _userA;
  DocumentReference? get userA => _userA;
  bool hasUserA() => _userA != null;

  // "user_b" field.
  DocumentReference? _userB;
  DocumentReference? get userB => _userB;
  bool hasUserB() => _userB != null;

  // "last_message_sent_by" field.
  DocumentReference? _lastMessageSentBy;
  DocumentReference? get lastMessageSentBy => _lastMessageSentBy;
  bool hasLastMessageSentBy() => _lastMessageSentBy != null;

  // "last_message_seen_by" field.
  List<DocumentReference>? _lastMessageSeenBy;
  List<DocumentReference> get lastMessageSeenBy =>
      _lastMessageSeenBy ?? const [];
  bool hasLastMessageSeenBy() => _lastMessageSeenBy != null;

  // "group_chat_id" field.
  int? _groupChatId;
  int get groupChatId => _groupChatId ?? 0;
  bool hasGroupChatId() => _groupChatId != null;

  // "productRef" field.
  DocumentReference? _productRef;
  DocumentReference? get productRef => _productRef;
  bool hasProductRef() => _productRef != null;

  // "isListingMessage" field.
  bool? _isListingMessage;
  bool get isListingMessage => _isListingMessage ?? false;
  bool hasIsListingMessage() => _isListingMessage != null;

  // "isEmptyChat" field.
  bool? _isEmptyChat;
  bool get isEmptyChat => _isEmptyChat ?? false;
  bool hasIsEmptyChat() => _isEmptyChat != null;

  // "pendingBasket" field.
  DocumentReference? _pendingBasket;
  DocumentReference? get pendingBasket => _pendingBasket;
  bool hasPendingBasket() => _pendingBasket != null;

  void _initializeFields() {
    _lastMessage = snapshotData['last_message'] as String?;
    _lastMessageTime = snapshotData['last_message_time'] as DateTime?;
    _users = getDataList(snapshotData['users']);
    _participantsID = getDataList(snapshotData['participants_ID']);
    _participantsNames = getDataList(snapshotData['participants_names']);
    _participantsImages = getDataList(snapshotData['participants_images']);
    _userA = snapshotData['user_a'] as DocumentReference?;
    _userB = snapshotData['user_b'] as DocumentReference?;
    _lastMessageSentBy =
        snapshotData['last_message_sent_by'] as DocumentReference?;
    _lastMessageSeenBy = getDataList(snapshotData['last_message_seen_by']);
    _groupChatId = castToType<int>(snapshotData['group_chat_id']);
    _productRef = snapshotData['productRef'] as DocumentReference?;
    _isListingMessage = snapshotData['isListingMessage'] as bool?;
    _isEmptyChat = snapshotData['isEmptyChat'] as bool?;
    _pendingBasket = snapshotData['pendingBasket'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chats');

  static Stream<ChatsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatsRecord.fromSnapshot(s));

  static Future<ChatsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatsRecord.fromSnapshot(s));

  static ChatsRecord fromSnapshot(DocumentSnapshot snapshot) => ChatsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatsRecordData({
  String? lastMessage,
  DateTime? lastMessageTime,
  DocumentReference? userA,
  DocumentReference? userB,
  DocumentReference? lastMessageSentBy,
  int? groupChatId,
  DocumentReference? productRef,
  bool? isListingMessage,
  bool? isEmptyChat,
  DocumentReference? pendingBasket,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'last_message': lastMessage,
      'last_message_time': lastMessageTime,
      'user_a': userA,
      'user_b': userB,
      'last_message_sent_by': lastMessageSentBy,
      'group_chat_id': groupChatId,
      'productRef': productRef,
      'isListingMessage': isListingMessage,
      'isEmptyChat': isEmptyChat,
      'pendingBasket': pendingBasket,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatsRecordDocumentEquality implements Equality<ChatsRecord> {
  const ChatsRecordDocumentEquality();

  @override
  bool equals(ChatsRecord? e1, ChatsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.lastMessage == e2?.lastMessage &&
        e1?.lastMessageTime == e2?.lastMessageTime &&
        listEquality.equals(e1?.users, e2?.users) &&
        listEquality.equals(e1?.participantsID, e2?.participantsID) &&
        listEquality.equals(e1?.participantsNames, e2?.participantsNames) &&
        listEquality.equals(e1?.participantsImages, e2?.participantsImages) &&
        e1?.userA == e2?.userA &&
        e1?.userB == e2?.userB &&
        e1?.lastMessageSentBy == e2?.lastMessageSentBy &&
        listEquality.equals(e1?.lastMessageSeenBy, e2?.lastMessageSeenBy) &&
        e1?.groupChatId == e2?.groupChatId &&
        e1?.productRef == e2?.productRef &&
        e1?.isListingMessage == e2?.isListingMessage &&
        e1?.isEmptyChat == e2?.isEmptyChat &&
        e1?.pendingBasket == e2?.pendingBasket;
  }

  @override
  int hash(ChatsRecord? e) => const ListEquality().hash([
        e?.lastMessage,
        e?.lastMessageTime,
        e?.users,
        e?.participantsID,
        e?.participantsNames,
        e?.participantsImages,
        e?.userA,
        e?.userB,
        e?.lastMessageSentBy,
        e?.lastMessageSeenBy,
        e?.groupChatId,
        e?.productRef,
        e?.isListingMessage,
        e?.isEmptyChat,
        e?.pendingBasket
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatsRecord;
}
