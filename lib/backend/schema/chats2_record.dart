import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class Chats2Record extends FirestoreRecord {
  Chats2Record._(
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

  void _initializeFields() {
    _lastMessage = snapshotData['last_message'] as String?;
    _lastMessageTime = snapshotData['last_message_time'] as DateTime?;
    _users = getDataList(snapshotData['users']);
    _userA = snapshotData['user_a'] as DocumentReference?;
    _userB = snapshotData['user_b'] as DocumentReference?;
    _lastMessageSentBy =
        snapshotData['last_message_sent_by'] as DocumentReference?;
    _lastMessageSeenBy = getDataList(snapshotData['last_message_seen_by']);
    _groupChatId = castToType<int>(snapshotData['group_chat_id']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('chats2');

  static Stream<Chats2Record> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => Chats2Record.fromSnapshot(s));

  static Future<Chats2Record> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => Chats2Record.fromSnapshot(s));

  static Chats2Record fromSnapshot(DocumentSnapshot snapshot) => Chats2Record._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static Chats2Record getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      Chats2Record._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'Chats2Record(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is Chats2Record &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChats2RecordData({
  String? lastMessage,
  DateTime? lastMessageTime,
  DocumentReference? userA,
  DocumentReference? userB,
  DocumentReference? lastMessageSentBy,
  int? groupChatId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'last_message': lastMessage,
      'last_message_time': lastMessageTime,
      'user_a': userA,
      'user_b': userB,
      'last_message_sent_by': lastMessageSentBy,
      'group_chat_id': groupChatId,
    }.withoutNulls,
  );

  return firestoreData;
}

class Chats2RecordDocumentEquality implements Equality<Chats2Record> {
  const Chats2RecordDocumentEquality();

  @override
  bool equals(Chats2Record? e1, Chats2Record? e2) {
    const listEquality = ListEquality();
    return e1?.lastMessage == e2?.lastMessage &&
        e1?.lastMessageTime == e2?.lastMessageTime &&
        listEquality.equals(e1?.users, e2?.users) &&
        e1?.userA == e2?.userA &&
        e1?.userB == e2?.userB &&
        e1?.lastMessageSentBy == e2?.lastMessageSentBy &&
        listEquality.equals(e1?.lastMessageSeenBy, e2?.lastMessageSeenBy) &&
        e1?.groupChatId == e2?.groupChatId;
  }

  @override
  int hash(Chats2Record? e) => const ListEquality().hash([
        e?.lastMessage,
        e?.lastMessageTime,
        e?.users,
        e?.userA,
        e?.userB,
        e?.lastMessageSentBy,
        e?.lastMessageSeenBy,
        e?.groupChatId
      ]);

  @override
  bool isValidKey(Object? o) => o is Chats2Record;
}
