import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GardensRecord extends FirestoreRecord {
  GardensRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "gardenName" field.
  String? _gardenName;
  String get gardenName => _gardenName ?? '';
  bool hasGardenName() => _gardenName != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "lighting" field.
  String? _lighting;
  String get lighting => _lighting ?? '';
  bool hasLighting() => _lighting != null;

  // "public" field.
  bool? _public;
  bool get public => _public ?? false;
  bool hasPublic() => _public != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "numPlants" field.
  int? _numPlants;
  int get numPlants => _numPlants ?? 0;
  bool hasNumPlants() => _numPlants != null;

  // "imageurl" field.
  String? _imageurl;
  String get imageurl => _imageurl ?? '';
  bool hasImageurl() => _imageurl != null;

  // "indoorOutdoor" field.
  String? _indoorOutdoor;
  String get indoorOutdoor => _indoorOutdoor ?? '';
  bool hasIndoorOutdoor() => _indoorOutdoor != null;

  // "soilType" field.
  String? _soilType;
  String get soilType => _soilType ?? '';
  bool hasSoilType() => _soilType != null;

  // "dateCreated" field.
  DateTime? _dateCreated;
  DateTime? get dateCreated => _dateCreated;
  bool hasDateCreated() => _dateCreated != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _gardenName = snapshotData['gardenName'] as String?;
    _description = snapshotData['description'] as String?;
    _lighting = snapshotData['lighting'] as String?;
    _public = snapshotData['public'] as bool?;
    _location = snapshotData['location'] as String?;
    _numPlants = castToType<int>(snapshotData['numPlants']);
    _imageurl = snapshotData['imageurl'] as String?;
    _indoorOutdoor = snapshotData['indoorOutdoor'] as String?;
    _soilType = snapshotData['soilType'] as String?;
    _dateCreated = snapshotData['dateCreated'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('gardens');

  static Stream<GardensRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GardensRecord.fromSnapshot(s));

  static Future<GardensRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GardensRecord.fromSnapshot(s));

  static GardensRecord fromSnapshot(DocumentSnapshot snapshot) =>
      GardensRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GardensRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GardensRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GardensRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GardensRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGardensRecordData({
  String? uid,
  String? gardenName,
  String? description,
  String? lighting,
  bool? public,
  String? location,
  int? numPlants,
  String? imageurl,
  String? indoorOutdoor,
  String? soilType,
  DateTime? dateCreated,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'gardenName': gardenName,
      'description': description,
      'lighting': lighting,
      'public': public,
      'location': location,
      'numPlants': numPlants,
      'imageurl': imageurl,
      'indoorOutdoor': indoorOutdoor,
      'soilType': soilType,
      'dateCreated': dateCreated,
    }.withoutNulls,
  );

  return firestoreData;
}

class GardensRecordDocumentEquality implements Equality<GardensRecord> {
  const GardensRecordDocumentEquality();

  @override
  bool equals(GardensRecord? e1, GardensRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.gardenName == e2?.gardenName &&
        e1?.description == e2?.description &&
        e1?.lighting == e2?.lighting &&
        e1?.public == e2?.public &&
        e1?.location == e2?.location &&
        e1?.numPlants == e2?.numPlants &&
        e1?.imageurl == e2?.imageurl &&
        e1?.indoorOutdoor == e2?.indoorOutdoor &&
        e1?.soilType == e2?.soilType &&
        e1?.dateCreated == e2?.dateCreated;
  }

  @override
  int hash(GardensRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.gardenName,
        e?.description,
        e?.lighting,
        e?.public,
        e?.location,
        e?.numPlants,
        e?.imageurl,
        e?.indoorOutdoor,
        e?.soilType,
        e?.dateCreated
      ]);

  @override
  bool isValidKey(Object? o) => o is GardensRecord;
}
