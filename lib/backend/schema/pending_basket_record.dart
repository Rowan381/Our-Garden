import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PendingBasketRecord extends FirestoreRecord {
  PendingBasketRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "sellerRef" field.
  DocumentReference? _sellerRef;
  DocumentReference? get sellerRef => _sellerRef;
  bool hasSellerRef() => _sellerRef != null;

  // "buyerRef" field.
  DocumentReference? _buyerRef;
  DocumentReference? get buyerRef => _buyerRef;
  bool hasBuyerRef() => _buyerRef != null;

  // "basketItems" field.
  List<BasketItemStruct>? _basketItems;
  List<BasketItemStruct> get basketItems => _basketItems ?? const [];
  bool hasBasketItems() => _basketItems != null;

  void _initializeFields() {
    _sellerRef = snapshotData['sellerRef'] as DocumentReference?;
    _buyerRef = snapshotData['buyerRef'] as DocumentReference?;
    _basketItems = getStructList(
      snapshotData['basketItems'],
      BasketItemStruct.fromMap,
    );
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('pendingBasket');

  static Stream<PendingBasketRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PendingBasketRecord.fromSnapshot(s));

  static Future<PendingBasketRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PendingBasketRecord.fromSnapshot(s));

  static PendingBasketRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PendingBasketRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PendingBasketRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PendingBasketRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PendingBasketRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PendingBasketRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPendingBasketRecordData({
  DocumentReference? sellerRef,
  DocumentReference? buyerRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sellerRef': sellerRef,
      'buyerRef': buyerRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class PendingBasketRecordDocumentEquality
    implements Equality<PendingBasketRecord> {
  const PendingBasketRecordDocumentEquality();

  @override
  bool equals(PendingBasketRecord? e1, PendingBasketRecord? e2) {
    const listEquality = ListEquality();
    return e1?.sellerRef == e2?.sellerRef &&
        e1?.buyerRef == e2?.buyerRef &&
        listEquality.equals(e1?.basketItems, e2?.basketItems);
  }

  @override
  int hash(PendingBasketRecord? e) =>
      const ListEquality().hash([e?.sellerRef, e?.buyerRef, e?.basketItems]);

  @override
  bool isValidKey(Object? o) => o is PendingBasketRecord;
}
