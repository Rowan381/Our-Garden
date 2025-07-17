import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CommonPlantsRecord extends FirestoreRecord {
  CommonPlantsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "species" field.
  String? _species;
  String get species => _species ?? '';
  bool hasSpecies() => _species != null;

  // "blurb" field.
  String? _blurb;
  String get blurb => _blurb ?? '';
  bool hasBlurb() => _blurb != null;

  // "imageURL" field.
  String? _imageURL;
  String get imageURL => _imageURL ?? '';
  bool hasImageURL() => _imageURL != null;

  void _initializeFields() {
    _species = snapshotData['species'] as String?;
    _blurb = snapshotData['blurb'] as String?;
    _imageURL = snapshotData['imageURL'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('commonPlants');

  static Stream<CommonPlantsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CommonPlantsRecord.fromSnapshot(s));

  static Future<CommonPlantsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CommonPlantsRecord.fromSnapshot(s));

  static CommonPlantsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CommonPlantsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CommonPlantsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CommonPlantsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CommonPlantsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CommonPlantsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCommonPlantsRecordData({
  String? species,
  String? blurb,
  String? imageURL,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'species': species,
      'blurb': blurb,
      'imageURL': imageURL,
    }.withoutNulls,
  );

  return firestoreData;
}

class CommonPlantsRecordDocumentEquality
    implements Equality<CommonPlantsRecord> {
  const CommonPlantsRecordDocumentEquality();

  @override
  bool equals(CommonPlantsRecord? e1, CommonPlantsRecord? e2) {
    return e1?.species == e2?.species &&
        e1?.blurb == e2?.blurb &&
        e1?.imageURL == e2?.imageURL;
  }

  @override
  int hash(CommonPlantsRecord? e) =>
      const ListEquality().hash([e?.species, e?.blurb, e?.imageURL]);

  @override
  bool isValidKey(Object? o) => o is CommonPlantsRecord;
}
