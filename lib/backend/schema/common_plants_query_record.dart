import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CommonPlantsQueryRecord extends FirestoreRecord {
  CommonPlantsQueryRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user" field.
  String? _user;
  String get user => _user ?? '';
  bool hasUser() => _user != null;

  // "query" field.
  String? _query;
  String get query => _query ?? '';
  bool hasQuery() => _query != null;

  void _initializeFields() {
    _user = snapshotData['user'] as String?;
    _query = snapshotData['query'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('commonPlantsQuery');

  static Stream<CommonPlantsQueryRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CommonPlantsQueryRecord.fromSnapshot(s));

  static Future<CommonPlantsQueryRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => CommonPlantsQueryRecord.fromSnapshot(s));

  static CommonPlantsQueryRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CommonPlantsQueryRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CommonPlantsQueryRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CommonPlantsQueryRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CommonPlantsQueryRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CommonPlantsQueryRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCommonPlantsQueryRecordData({
  String? user,
  String? query,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'query': query,
    }.withoutNulls,
  );

  return firestoreData;
}

class CommonPlantsQueryRecordDocumentEquality
    implements Equality<CommonPlantsQueryRecord> {
  const CommonPlantsQueryRecordDocumentEquality();

  @override
  bool equals(CommonPlantsQueryRecord? e1, CommonPlantsQueryRecord? e2) {
    return e1?.user == e2?.user && e1?.query == e2?.query;
  }

  @override
  int hash(CommonPlantsQueryRecord? e) =>
      const ListEquality().hash([e?.user, e?.query]);

  @override
  bool isValidKey(Object? o) => o is CommonPlantsQueryRecord;
}
