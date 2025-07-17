// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class OrderItemsStruct extends FFFirebaseStruct {
  OrderItemsStruct({
    int? quantity,
    double? totalPrice,
    String? image,
    String? productName,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _quantity = quantity,
        _totalPrice = totalPrice,
        _image = image,
        _productName = productName,
        super(firestoreUtilData);

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  set quantity(int? val) => _quantity = val;

  void incrementQuantity(int amount) => quantity = quantity + amount;

  bool hasQuantity() => _quantity != null;

  // "totalPrice" field.
  double? _totalPrice;
  double get totalPrice => _totalPrice ?? 0.0;
  set totalPrice(double? val) => _totalPrice = val;

  void incrementTotalPrice(double amount) => totalPrice = totalPrice + amount;

  bool hasTotalPrice() => _totalPrice != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "productName" field.
  String? _productName;
  String get productName => _productName ?? '';
  set productName(String? val) => _productName = val;

  bool hasProductName() => _productName != null;

  static OrderItemsStruct fromMap(Map<String, dynamic> data) =>
      OrderItemsStruct(
        quantity: castToType<int>(data['quantity']),
        totalPrice: castToType<double>(data['totalPrice']),
        image: data['image'] as String?,
        productName: data['productName'] as String?,
      );

  static OrderItemsStruct? maybeFromMap(dynamic data) => data is Map
      ? OrderItemsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'quantity': _quantity,
        'totalPrice': _totalPrice,
        'image': _image,
        'productName': _productName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'quantity': serializeParam(
          _quantity,
          ParamType.int,
        ),
        'totalPrice': serializeParam(
          _totalPrice,
          ParamType.double,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'productName': serializeParam(
          _productName,
          ParamType.String,
        ),
      }.withoutNulls;

  static OrderItemsStruct fromSerializableMap(Map<String, dynamic> data) =>
      OrderItemsStruct(
        quantity: deserializeParam(
          data['quantity'],
          ParamType.int,
          false,
        ),
        totalPrice: deserializeParam(
          data['totalPrice'],
          ParamType.double,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        productName: deserializeParam(
          data['productName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'OrderItemsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OrderItemsStruct &&
        quantity == other.quantity &&
        totalPrice == other.totalPrice &&
        image == other.image &&
        productName == other.productName;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([quantity, totalPrice, image, productName]);
}

OrderItemsStruct createOrderItemsStruct({
  int? quantity,
  double? totalPrice,
  String? image,
  String? productName,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    OrderItemsStruct(
      quantity: quantity,
      totalPrice: totalPrice,
      image: image,
      productName: productName,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

OrderItemsStruct? updateOrderItemsStruct(
  OrderItemsStruct? orderItems, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    orderItems
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addOrderItemsStructData(
  Map<String, dynamic> firestoreData,
  OrderItemsStruct? orderItems,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (orderItems == null) {
    return;
  }
  if (orderItems.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && orderItems.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final orderItemsData = getOrderItemsFirestoreData(orderItems, forFieldValue);
  final nestedData = orderItemsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = orderItems.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getOrderItemsFirestoreData(
  OrderItemsStruct? orderItems, [
  bool forFieldValue = false,
]) {
  if (orderItems == null) {
    return {};
  }
  final firestoreData = mapToFirestore(orderItems.toMap());

  // Add any Firestore field values
  orderItems.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getOrderItemsListFirestoreData(
  List<OrderItemsStruct>? orderItemss,
) =>
    orderItemss?.map((e) => getOrderItemsFirestoreData(e, true)).toList() ?? [];
