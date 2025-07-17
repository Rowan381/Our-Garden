import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatsMessagesRecord extends FirestoreRecord {
  ChatsMessagesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "messages" field.
  String? _messages;
  String get messages => _messages ?? '';
  bool hasMessages() => _messages != null;

  // "sender_ID" field.
  DocumentReference? _senderID;
  DocumentReference? get senderID => _senderID;
  bool hasSenderID() => _senderID != null;

  // "sender_name" field.
  String? _senderName;
  String get senderName => _senderName ?? '';
  bool hasSenderName() => _senderName != null;

  // "last_message_time" field.
  DateTime? _lastMessageTime;
  DateTime? get lastMessageTime => _lastMessageTime;
  bool hasLastMessageTime() => _lastMessageTime != null;

  // "sender_image" field.
  String? _senderImage;
  String get senderImage => _senderImage ?? '';
  bool hasSenderImage() => _senderImage != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _messages = snapshotData['messages'] as String?;
    _senderID = snapshotData['sender_ID'] as DocumentReference?;
    _senderName = snapshotData['sender_name'] as String?;
    _lastMessageTime = snapshotData['last_message_time'] as DateTime?;
    _senderImage = snapshotData['sender_image'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('chats_messages')
          : FirebaseFirestore.instance.collectionGroup('chats_messages');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('chats_messages').doc(id);

  static Stream<ChatsMessagesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChatsMessagesRecord.fromSnapshot(s));

  static Future<ChatsMessagesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChatsMessagesRecord.fromSnapshot(s));

  static ChatsMessagesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChatsMessagesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChatsMessagesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChatsMessagesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChatsMessagesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChatsMessagesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChatsMessagesRecordData({
  String? messages,
  DocumentReference? senderID,
  String? senderName,
  DateTime? lastMessageTime,
  String? senderImage,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'messages': messages,
      'sender_ID': senderID,
      'sender_name': senderName,
      'last_message_time': lastMessageTime,
      'sender_image': senderImage,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChatsMessagesRecordDocumentEquality
    implements Equality<ChatsMessagesRecord> {
  const ChatsMessagesRecordDocumentEquality();

  @override
  bool equals(ChatsMessagesRecord? e1, ChatsMessagesRecord? e2) {
    return e1?.messages == e2?.messages &&
        e1?.senderID == e2?.senderID &&
        e1?.senderName == e2?.senderName &&
        e1?.lastMessageTime == e2?.lastMessageTime &&
        e1?.senderImage == e2?.senderImage;
  }

  @override
  int hash(ChatsMessagesRecord? e) => const ListEquality().hash([
        e?.messages,
        e?.senderID,
        e?.senderName,
        e?.lastMessageTime,
        e?.senderImage
      ]);

  @override
  bool isValidKey(Object? o) => o is ChatsMessagesRecord;
}
