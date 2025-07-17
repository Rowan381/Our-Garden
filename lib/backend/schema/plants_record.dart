import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlantsRecord extends FirestoreRecord {
  PlantsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userCreatorID" field.
  String? _userCreatorID;
  String get userCreatorID => _userCreatorID ?? '';
  bool hasUserCreatorID() => _userCreatorID != null;

  // "plantIMGURL" field.
  String? _plantIMGURL;
  String get plantIMGURL => _plantIMGURL ?? '';
  bool hasPlantIMGURL() => _plantIMGURL != null;

  // "gardenCreatorRef" field.
  DocumentReference? _gardenCreatorRef;
  DocumentReference? get gardenCreatorRef => _gardenCreatorRef;
  bool hasGardenCreatorRef() => _gardenCreatorRef != null;

  // "plantID" field.
  String? _plantID;
  String get plantID => _plantID ?? '';
  bool hasPlantID() => _plantID != null;

  // "plantSpecies" field.
  String? _plantSpecies;
  String get plantSpecies => _plantSpecies ?? '';
  bool hasPlantSpecies() => _plantSpecies != null;

  // "dateCreated" field.
  DateTime? _dateCreated;
  DateTime? get dateCreated => _dateCreated;
  bool hasDateCreated() => _dateCreated != null;

  void _initializeFields() {
    _userCreatorID = snapshotData['userCreatorID'] as String?;
    _plantIMGURL = snapshotData['plantIMGURL'] as String?;
    _gardenCreatorRef = snapshotData['gardenCreatorRef'] as DocumentReference?;
    _plantID = snapshotData['plantID'] as String?;
    _plantSpecies = snapshotData['plantSpecies'] as String?;
    _dateCreated = snapshotData['dateCreated'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('plants');

  static Stream<PlantsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlantsRecord.fromSnapshot(s));

  static Future<PlantsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlantsRecord.fromSnapshot(s));

  static PlantsRecord fromSnapshot(DocumentSnapshot snapshot) => PlantsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlantsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlantsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlantsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlantsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlantsRecordData({
  String? userCreatorID,
  String? plantIMGURL,
  DocumentReference? gardenCreatorRef,
  String? plantID,
  String? plantSpecies,
  DateTime? dateCreated,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userCreatorID': userCreatorID,
      'plantIMGURL': plantIMGURL,
      'gardenCreatorRef': gardenCreatorRef,
      'plantID': plantID,
      'plantSpecies': plantSpecies,
      'dateCreated': dateCreated,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlantsRecordDocumentEquality implements Equality<PlantsRecord> {
  const PlantsRecordDocumentEquality();

  @override
  bool equals(PlantsRecord? e1, PlantsRecord? e2) {
    return e1?.userCreatorID == e2?.userCreatorID &&
        e1?.plantIMGURL == e2?.plantIMGURL &&
        e1?.gardenCreatorRef == e2?.gardenCreatorRef &&
        e1?.plantID == e2?.plantID &&
        e1?.plantSpecies == e2?.plantSpecies &&
        e1?.dateCreated == e2?.dateCreated;
  }

  @override
  int hash(PlantsRecord? e) => const ListEquality().hash([
        e?.userCreatorID,
        e?.plantIMGURL,
        e?.gardenCreatorRef,
        e?.plantID,
        e?.plantSpecies,
        e?.dateCreated
      ]);

  @override
  bool isValidKey(Object? o) => o is PlantsRecord;
}
