import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FiltersRecord extends FirestoreRecord {
  FiltersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "types" field.
  List<String>? _types;
  List<String> get types => _types ?? const [];
  bool hasTypes() => _types != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _type = snapshotData['type'] as String?;
    _types = getDataList(snapshotData['types']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('filters');

  static Stream<FiltersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FiltersRecord.fromSnapshot(s));

  static Future<FiltersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FiltersRecord.fromSnapshot(s));

  static FiltersRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FiltersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FiltersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FiltersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FiltersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FiltersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFiltersRecordData({
  String? name,
  String? type,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'type': type,
    }.withoutNulls,
  );

  return firestoreData;
}

class FiltersRecordDocumentEquality implements Equality<FiltersRecord> {
  const FiltersRecordDocumentEquality();

  @override
  bool equals(FiltersRecord? e1, FiltersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.type == e2?.type &&
        listEquality.equals(e1?.types, e2?.types);
  }

  @override
  int hash(FiltersRecord? e) =>
      const ListEquality().hash([e?.name, e?.type, e?.types]);

  @override
  bool isValidKey(Object? o) => o is FiltersRecord;
}
