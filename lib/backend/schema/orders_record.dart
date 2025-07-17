import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrdersRecord extends FirestoreRecord {
  OrdersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "buyer" field.
  DocumentReference? _buyer;
  DocumentReference? get buyer => _buyer;
  bool hasBuyer() => _buyer != null;

  // "seller" field.
  DocumentReference? _seller;
  DocumentReference? get seller => _seller;
  bool hasSeller() => _seller != null;

  // "fulfillImage" field.
  String? _fulfillImage;
  String get fulfillImage => _fulfillImage ?? '';
  bool hasFulfillImage() => _fulfillImage != null;

  // "items" field.
  List<OrderItemsStruct>? _items;
  List<OrderItemsStruct> get items => _items ?? const [];
  bool hasItems() => _items != null;

  // "totalPrice" field.
  double? _totalPrice;
  double get totalPrice => _totalPrice ?? 0.0;
  bool hasTotalPrice() => _totalPrice != null;

  // "buyerPaid" field.
  bool? _buyerPaid;
  bool get buyerPaid => _buyerPaid ?? false;
  bool hasBuyerPaid() => _buyerPaid != null;

  // "stripeSessionID" field.
  String? _stripeSessionID;
  String get stripeSessionID => _stripeSessionID ?? '';
  bool hasStripeSessionID() => _stripeSessionID != null;

  void _initializeFields() {
    _buyer = snapshotData['buyer'] as DocumentReference?;
    _seller = snapshotData['seller'] as DocumentReference?;
    _fulfillImage = snapshotData['fulfillImage'] as String?;
    _items = getStructList(
      snapshotData['items'],
      OrderItemsStruct.fromMap,
    );
    _totalPrice = castToType<double>(snapshotData['totalPrice']);
    _buyerPaid = snapshotData['buyerPaid'] as bool?;
    _stripeSessionID = snapshotData['stripeSessionID'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('orders');

  static Stream<OrdersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OrdersRecord.fromSnapshot(s));

  static Future<OrdersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OrdersRecord.fromSnapshot(s));

  static OrdersRecord fromSnapshot(DocumentSnapshot snapshot) => OrdersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OrdersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OrdersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OrdersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OrdersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOrdersRecordData({
  DocumentReference? buyer,
  DocumentReference? seller,
  String? fulfillImage,
  double? totalPrice,
  bool? buyerPaid,
  String? stripeSessionID,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'buyer': buyer,
      'seller': seller,
      'fulfillImage': fulfillImage,
      'totalPrice': totalPrice,
      'buyerPaid': buyerPaid,
      'stripeSessionID': stripeSessionID,
    }.withoutNulls,
  );

  return firestoreData;
}

class OrdersRecordDocumentEquality implements Equality<OrdersRecord> {
  const OrdersRecordDocumentEquality();

  @override
  bool equals(OrdersRecord? e1, OrdersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.buyer == e2?.buyer &&
        e1?.seller == e2?.seller &&
        e1?.fulfillImage == e2?.fulfillImage &&
        listEquality.equals(e1?.items, e2?.items) &&
        e1?.totalPrice == e2?.totalPrice &&
        e1?.buyerPaid == e2?.buyerPaid &&
        e1?.stripeSessionID == e2?.stripeSessionID;
  }

  @override
  int hash(OrdersRecord? e) => const ListEquality().hash([
        e?.buyer,
        e?.seller,
        e?.fulfillImage,
        e?.items,
        e?.totalPrice,
        e?.buyerPaid,
        e?.stripeSessionID
      ]);

  @override
  bool isValidKey(Object? o) => o is OrdersRecord;
}
