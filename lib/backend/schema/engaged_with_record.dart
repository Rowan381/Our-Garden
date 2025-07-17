import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EngagedWithRecord extends FirestoreRecord {
  EngagedWithRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "ID" field.
  DocumentReference? _id;
  DocumentReference? get id => _id;
  bool hasId() => _id != null;

  // "photo" field.
  String? _photo;
  String get photo => _photo ?? '';
  bool hasPhoto() => _photo != null;

  // "chatID" field.
  DocumentReference? _chatID;
  DocumentReference? get chatID => _chatID;
  bool hasChatID() => _chatID != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _id = snapshotData['ID'] as DocumentReference?;
    _photo = snapshotData['photo'] as String?;
    _chatID = snapshotData['chatID'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('engaged_with')
          : FirebaseFirestore.instance.collectionGroup('engaged_with');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('engaged_with').doc(id);

  static Stream<EngagedWithRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EngagedWithRecord.fromSnapshot(s));

  static Future<EngagedWithRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EngagedWithRecord.fromSnapshot(s));

  static EngagedWithRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EngagedWithRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EngagedWithRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EngagedWithRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EngagedWithRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EngagedWithRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEngagedWithRecordData({
  String? name,
  DocumentReference? id,
  String? photo,
  DocumentReference? chatID,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'ID': id,
      'photo': photo,
      'chatID': chatID,
    }.withoutNulls,
  );

  return firestoreData;
}

class EngagedWithRecordDocumentEquality implements Equality<EngagedWithRecord> {
  const EngagedWithRecordDocumentEquality();

  @override
  bool equals(EngagedWithRecord? e1, EngagedWithRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.id == e2?.id &&
        e1?.photo == e2?.photo &&
        e1?.chatID == e2?.chatID;
  }

  @override
  int hash(EngagedWithRecord? e) =>
      const ListEquality().hash([e?.name, e?.id, e?.photo, e?.chatID]);

  @override
  bool isValidKey(Object? o) => o is EngagedWithRecord;
}
