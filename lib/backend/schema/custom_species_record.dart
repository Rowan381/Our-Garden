import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CustomSpeciesRecord extends FirestoreRecord {
  CustomSpeciesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "imageURL" field.
  String? _imageURL;
  String get imageURL => _imageURL ?? '';
  bool hasImageURL() => _imageURL != null;

  // "speciesName" field.
  String? _speciesName;
  String get speciesName => _speciesName ?? '';
  bool hasSpeciesName() => _speciesName != null;

  // "blurb" field.
  String? _blurb;
  String get blurb => _blurb ?? '';
  bool hasBlurb() => _blurb != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _imageURL = snapshotData['imageURL'] as String?;
    _speciesName = snapshotData['speciesName'] as String?;
    _blurb = snapshotData['blurb'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('customSpecies');

  static Stream<CustomSpeciesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CustomSpeciesRecord.fromSnapshot(s));

  static Future<CustomSpeciesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CustomSpeciesRecord.fromSnapshot(s));

  static CustomSpeciesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CustomSpeciesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CustomSpeciesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CustomSpeciesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CustomSpeciesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CustomSpeciesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCustomSpeciesRecordData({
  String? uid,
  String? imageURL,
  String? speciesName,
  String? blurb,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'imageURL': imageURL,
      'speciesName': speciesName,
      'blurb': blurb,
    }.withoutNulls,
  );

  return firestoreData;
}

class CustomSpeciesRecordDocumentEquality
    implements Equality<CustomSpeciesRecord> {
  const CustomSpeciesRecordDocumentEquality();

  @override
  bool equals(CustomSpeciesRecord? e1, CustomSpeciesRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.imageURL == e2?.imageURL &&
        e1?.speciesName == e2?.speciesName &&
        e1?.blurb == e2?.blurb;
  }

  @override
  int hash(CustomSpeciesRecord? e) => const ListEquality()
      .hash([e?.uid, e?.imageURL, e?.speciesName, e?.blurb]);

  @override
  bool isValidKey(Object? o) => o is CustomSpeciesRecord;
}
