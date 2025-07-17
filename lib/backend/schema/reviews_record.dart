import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReviewsRecord extends FirestoreRecord {
  ReviewsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "review_text" field.
  String? _reviewText;
  String get reviewText => _reviewText ?? '';
  bool hasReviewText() => _reviewText != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "review_id" field.
  String? _reviewId;
  String get reviewId => _reviewId ?? '';
  bool hasReviewId() => _reviewId != null;

  // "buyer" field.
  DocumentReference? _buyer;
  DocumentReference? get buyer => _buyer;
  bool hasBuyer() => _buyer != null;

  // "thumbs_up" field.
  List<DocumentReference>? _thumbsUp;
  List<DocumentReference> get thumbsUp => _thumbsUp ?? const [];
  bool hasThumbsUp() => _thumbsUp != null;

  // "thumbs_down" field.
  List<DocumentReference>? _thumbsDown;
  List<DocumentReference> get thumbsDown => _thumbsDown ?? const [];
  bool hasThumbsDown() => _thumbsDown != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "thumbs_up2" field.
  bool? _thumbsUp2;
  bool get thumbsUp2 => _thumbsUp2 ?? false;
  bool hasThumbsUp2() => _thumbsUp2 != null;

  void _initializeFields() {
    _reviewText = snapshotData['review_text'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _reviewId = snapshotData['review_id'] as String?;
    _buyer = snapshotData['buyer'] as DocumentReference?;
    _thumbsUp = getDataList(snapshotData['thumbs_up']);
    _thumbsDown = getDataList(snapshotData['thumbs_down']);
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _thumbsUp2 = snapshotData['thumbs_up2'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reviews');

  static Stream<ReviewsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ReviewsRecord.fromSnapshot(s));

  static Future<ReviewsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ReviewsRecord.fromSnapshot(s));

  static ReviewsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ReviewsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ReviewsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ReviewsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ReviewsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ReviewsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createReviewsRecordData({
  String? reviewText,
  DateTime? timestamp,
  String? reviewId,
  DocumentReference? buyer,
  DocumentReference? userRef,
  bool? thumbsUp2,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'review_text': reviewText,
      'timestamp': timestamp,
      'review_id': reviewId,
      'buyer': buyer,
      'userRef': userRef,
      'thumbs_up2': thumbsUp2,
    }.withoutNulls,
  );

  return firestoreData;
}

class ReviewsRecordDocumentEquality implements Equality<ReviewsRecord> {
  const ReviewsRecordDocumentEquality();

  @override
  bool equals(ReviewsRecord? e1, ReviewsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.reviewText == e2?.reviewText &&
        e1?.timestamp == e2?.timestamp &&
        e1?.reviewId == e2?.reviewId &&
        e1?.buyer == e2?.buyer &&
        listEquality.equals(e1?.thumbsUp, e2?.thumbsUp) &&
        listEquality.equals(e1?.thumbsDown, e2?.thumbsDown) &&
        e1?.userRef == e2?.userRef &&
        e1?.thumbsUp2 == e2?.thumbsUp2;
  }

  @override
  int hash(ReviewsRecord? e) => const ListEquality().hash([
        e?.reviewText,
        e?.timestamp,
        e?.reviewId,
        e?.buyer,
        e?.thumbsUp,
        e?.thumbsDown,
        e?.userRef,
        e?.thumbsUp2
      ]);

  @override
  bool isValidKey(Object? o) => o is ReviewsRecord;
}
