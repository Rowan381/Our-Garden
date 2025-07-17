import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AIsuggestedQsRecord extends FirestoreRecord {
  AIsuggestedQsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Question" field.
  String? _question;
  String get question => _question ?? '';
  bool hasQuestion() => _question != null;

  // "Image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "Order" field.
  int? _order;
  int get order => _order ?? 0;
  bool hasOrder() => _order != null;

  void _initializeFields() {
    _question = snapshotData['Question'] as String?;
    _image = snapshotData['Image'] as String?;
    _order = castToType<int>(snapshotData['Order']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('AIsuggestedQs');

  static Stream<AIsuggestedQsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AIsuggestedQsRecord.fromSnapshot(s));

  static Future<AIsuggestedQsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AIsuggestedQsRecord.fromSnapshot(s));

  static AIsuggestedQsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AIsuggestedQsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AIsuggestedQsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AIsuggestedQsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AIsuggestedQsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AIsuggestedQsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAIsuggestedQsRecordData({
  String? question,
  String? image,
  int? order,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Question': question,
      'Image': image,
      'Order': order,
    }.withoutNulls,
  );

  return firestoreData;
}

class AIsuggestedQsRecordDocumentEquality
    implements Equality<AIsuggestedQsRecord> {
  const AIsuggestedQsRecordDocumentEquality();

  @override
  bool equals(AIsuggestedQsRecord? e1, AIsuggestedQsRecord? e2) {
    return e1?.question == e2?.question &&
        e1?.image == e2?.image &&
        e1?.order == e2?.order;
  }

  @override
  int hash(AIsuggestedQsRecord? e) =>
      const ListEquality().hash([e?.question, e?.image, e?.order]);

  @override
  bool isValidKey(Object? o) => o is AIsuggestedQsRecord;
}
