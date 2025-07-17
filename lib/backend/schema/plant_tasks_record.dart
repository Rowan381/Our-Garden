import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlantTasksRecord extends FirestoreRecord {
  PlantTasksRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "frequencyNum" field.
  int? _frequencyNum;
  int get frequencyNum => _frequencyNum ?? 0;
  bool hasFrequencyNum() => _frequencyNum != null;

  // "frequencyType" field.
  String? _frequencyType;
  String get frequencyType => _frequencyType ?? '';
  bool hasFrequencyType() => _frequencyType != null;

  // "gardenCreatorRef" field.
  DocumentReference? _gardenCreatorRef;
  DocumentReference? get gardenCreatorRef => _gardenCreatorRef;
  bool hasGardenCreatorRef() => _gardenCreatorRef != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  bool hasNotes() => _notes != null;

  // "objective" field.
  String? _objective;
  String get objective => _objective ?? '';
  bool hasObjective() => _objective != null;

  // "occurrences" field.
  int? _occurrences;
  int get occurrences => _occurrences ?? 0;
  bool hasOccurrences() => _occurrences != null;

  // "plantCreatorRef" field.
  DocumentReference? _plantCreatorRef;
  DocumentReference? get plantCreatorRef => _plantCreatorRef;
  bool hasPlantCreatorRef() => _plantCreatorRef != null;

  // "startDate" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  bool hasStartDate() => _startDate != null;

  // "userCreatorID" field.
  String? _userCreatorID;
  String get userCreatorID => _userCreatorID ?? '';
  bool hasUserCreatorID() => _userCreatorID != null;

  // "completedToday" field.
  bool? _completedToday;
  bool get completedToday => _completedToday ?? false;
  bool hasCompletedToday() => _completedToday != null;

  void _initializeFields() {
    _frequencyNum = castToType<int>(snapshotData['frequencyNum']);
    _frequencyType = snapshotData['frequencyType'] as String?;
    _gardenCreatorRef = snapshotData['gardenCreatorRef'] as DocumentReference?;
    _notes = snapshotData['notes'] as String?;
    _objective = snapshotData['objective'] as String?;
    _occurrences = castToType<int>(snapshotData['occurrences']);
    _plantCreatorRef = snapshotData['plantCreatorRef'] as DocumentReference?;
    _startDate = snapshotData['startDate'] as DateTime?;
    _userCreatorID = snapshotData['userCreatorID'] as String?;
    _completedToday = snapshotData['completedToday'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('plantTasks');

  static Stream<PlantTasksRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlantTasksRecord.fromSnapshot(s));

  static Future<PlantTasksRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlantTasksRecord.fromSnapshot(s));

  static PlantTasksRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PlantTasksRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlantTasksRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlantTasksRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlantTasksRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlantTasksRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlantTasksRecordData({
  int? frequencyNum,
  String? frequencyType,
  DocumentReference? gardenCreatorRef,
  String? notes,
  String? objective,
  int? occurrences,
  DocumentReference? plantCreatorRef,
  DateTime? startDate,
  String? userCreatorID,
  bool? completedToday,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'frequencyNum': frequencyNum,
      'frequencyType': frequencyType,
      'gardenCreatorRef': gardenCreatorRef,
      'notes': notes,
      'objective': objective,
      'occurrences': occurrences,
      'plantCreatorRef': plantCreatorRef,
      'startDate': startDate,
      'userCreatorID': userCreatorID,
      'completedToday': completedToday,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlantTasksRecordDocumentEquality implements Equality<PlantTasksRecord> {
  const PlantTasksRecordDocumentEquality();

  @override
  bool equals(PlantTasksRecord? e1, PlantTasksRecord? e2) {
    return e1?.frequencyNum == e2?.frequencyNum &&
        e1?.frequencyType == e2?.frequencyType &&
        e1?.gardenCreatorRef == e2?.gardenCreatorRef &&
        e1?.notes == e2?.notes &&
        e1?.objective == e2?.objective &&
        e1?.occurrences == e2?.occurrences &&
        e1?.plantCreatorRef == e2?.plantCreatorRef &&
        e1?.startDate == e2?.startDate &&
        e1?.userCreatorID == e2?.userCreatorID &&
        e1?.completedToday == e2?.completedToday;
  }

  @override
  int hash(PlantTasksRecord? e) => const ListEquality().hash([
        e?.frequencyNum,
        e?.frequencyType,
        e?.gardenCreatorRef,
        e?.notes,
        e?.objective,
        e?.occurrences,
        e?.plantCreatorRef,
        e?.startDate,
        e?.userCreatorID,
        e?.completedToday
      ]);

  @override
  bool isValidKey(Object? o) => o is PlantTasksRecord;
}
