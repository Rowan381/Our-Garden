// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class BasketItemStruct extends FFFirebaseStruct {
  BasketItemStruct({
    DocumentReference? productRef,
    int? quantity,
    double? pricepu,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _productRef = productRef,
        _quantity = quantity,
        _pricepu = pricepu,
        super(firestoreUtilData);

  // "productRef" field.
  DocumentReference? _productRef;
  DocumentReference? get productRef => _productRef;
  set productRef(DocumentReference? val) => _productRef = val;

  bool hasProductRef() => _productRef != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  set quantity(int? val) => _quantity = val;

  void incrementQuantity(int amount) => quantity = quantity + amount;

  bool hasQuantity() => _quantity != null;

  // "pricepu" field.
  double? _pricepu;
  double get pricepu => _pricepu ?? 0.0;
  set pricepu(double? val) => _pricepu = val;

  void incrementPricepu(double amount) => pricepu = pricepu + amount;

  bool hasPricepu() => _pricepu != null;

  static BasketItemStruct fromMap(Map<String, dynamic> data) =>
      BasketItemStruct(
        productRef: data['productRef'] as DocumentReference?,
        quantity: castToType<int>(data['quantity']),
        pricepu: castToType<double>(data['pricepu']),
      );

  static BasketItemStruct? maybeFromMap(dynamic data) => data is Map
      ? BasketItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'productRef': _productRef,
        'quantity': _quantity,
        'pricepu': _pricepu,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'productRef': serializeParam(
          _productRef,
          ParamType.DocumentReference,
        ),
        'quantity': serializeParam(
          _quantity,
          ParamType.int,
        ),
        'pricepu': serializeParam(
          _pricepu,
          ParamType.double,
        ),
      }.withoutNulls;

  static BasketItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      BasketItemStruct(
        productRef: deserializeParam(
          data['productRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['product'],
        ),
        quantity: deserializeParam(
          data['quantity'],
          ParamType.int,
          false,
        ),
        pricepu: deserializeParam(
          data['pricepu'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'BasketItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BasketItemStruct &&
        productRef == other.productRef &&
        quantity == other.quantity &&
        pricepu == other.pricepu;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([productRef, quantity, pricepu]);
}

BasketItemStruct createBasketItemStruct({
  DocumentReference? productRef,
  int? quantity,
  double? pricepu,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BasketItemStruct(
      productRef: productRef,
      quantity: quantity,
      pricepu: pricepu,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BasketItemStruct? updateBasketItemStruct(
  BasketItemStruct? basketItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    basketItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBasketItemStructData(
  Map<String, dynamic> firestoreData,
  BasketItemStruct? basketItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (basketItem == null) {
    return;
  }
  if (basketItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && basketItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final basketItemData = getBasketItemFirestoreData(basketItem, forFieldValue);
  final nestedData = basketItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = basketItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBasketItemFirestoreData(
  BasketItemStruct? basketItem, [
  bool forFieldValue = false,
]) {
  if (basketItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(basketItem.toMap());

  // Add any Firestore field values
  basketItem.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBasketItemListFirestoreData(
  List<BasketItemStruct>? basketItems,
) =>
    basketItems?.map((e) => getBasketItemFirestoreData(e, true)).toList() ?? [];
