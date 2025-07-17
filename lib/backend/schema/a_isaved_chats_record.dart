import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AIsavedChatsRecord extends FirestoreRecord {
  AIsavedChatsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "chatHist" field.
  List<ContentStruct>? _chatHist;
  List<ContentStruct> get chatHist => _chatHist ?? const [];
  bool hasChatHist() => _chatHist != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  void _initializeFields() {
    _user = snapshotData['user'] as DocumentReference?;
    _date = snapshotData['date'] as DateTime?;
    _chatHist = getStructList(
      snapshotData['chatHist'],
      ContentStruct.fromMap,
    );
    _title = snapshotData['title'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('AIsavedChats');

  static Stream<AIsavedChatsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AIsavedChatsRecord.fromSnapshot(s));

  static Future<AIsavedChatsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AIsavedChatsRecord.fromSnapshot(s));

  static AIsavedChatsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AIsavedChatsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AIsavedChatsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AIsavedChatsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AIsavedChatsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AIsavedChatsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAIsavedChatsRecordData({
  DocumentReference? user,
  DateTime? date,
  String? title,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'date': date,
      'title': title,
    }.withoutNulls,
  );

  return firestoreData;
}

class AIsavedChatsRecordDocumentEquality
    implements Equality<AIsavedChatsRecord> {
  const AIsavedChatsRecordDocumentEquality();

  @override
  bool equals(AIsavedChatsRecord? e1, AIsavedChatsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.user == e2?.user &&
        e1?.date == e2?.date &&
        listEquality.equals(e1?.chatHist, e2?.chatHist) &&
        e1?.title == e2?.title;
  }

  @override
  int hash(AIsavedChatsRecord? e) =>
      const ListEquality().hash([e?.user, e?.date, e?.chatHist, e?.title]);

  @override
  bool isValidKey(Object? o) => o is AIsavedChatsRecord;
}
