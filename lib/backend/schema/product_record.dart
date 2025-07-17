import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProductRecord extends FirestoreRecord {
  ProductRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "modified_at" field.
  DateTime? _modifiedAt;
  DateTime? get modifiedAt => _modifiedAt;
  bool hasModifiedAt() => _modifiedAt != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  // "seller" field.
  DocumentReference? _seller;
  DocumentReference? get seller => _seller;
  bool hasSeller() => _seller != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "units" field.
  int? _units;
  int get units => _units ?? 0;
  bool hasUnits() => _units != null;

  // "for_sale" field.
  bool? _forSale;
  bool get forSale => _forSale ?? false;
  bool hasForSale() => _forSale != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "listingFilters" field.
  List<String>? _listingFilters;
  List<String> get listingFilters => _listingFilters ?? const [];
  bool hasListingFilters() => _listingFilters != null;

  // "sellerName" field.
  String? _sellerName;
  String get sellerName => _sellerName ?? '';
  bool hasSellerName() => _sellerName != null;

  // "unitType" field.
  String? _unitType;
  String get unitType => _unitType ?? '';
  bool hasUnitType() => _unitType != null;

  // "produceType" field.
  bool? _produceType;
  bool get produceType => _produceType ?? false;
  bool hasProduceType() => _produceType != null;

  // "gardenType" field.
  bool? _gardenType;
  bool get gardenType => _gardenType ?? false;
  bool hasGardenType() => _gardenType != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "sellerImage" field.
  String? _sellerImage;
  String get sellerImage => _sellerImage ?? '';
  bool hasSellerImage() => _sellerImage != null;

  // "locationCity" field.
  String? _locationCity;
  String get locationCity => _locationCity ?? '';
  bool hasLocationCity() => _locationCity != null;

  // "isArchived" field.
  bool? _isArchived;
  bool get isArchived => _isArchived ?? false;
  bool hasIsArchived() => _isArchived != null;

  // "psold" field.
  int? _psold;
  int get psold => _psold ?? 0;
  bool hasPsold() => _psold != null;

  // "itemForm" field.
  String? _itemForm;
  String get itemForm => _itemForm ?? '';
  bool hasItemForm() => _itemForm != null;

  // "tempCondition" field.
  String? _tempCondition;
  String get tempCondition => _tempCondition ?? '';
  bool hasTempCondition() => _tempCondition != null;

  void _initializeFields() {
    _description = snapshotData['description'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _modifiedAt = snapshotData['modified_at'] as DateTime?;
    _id = snapshotData['id'] as String?;
    _seller = snapshotData['seller'] as DocumentReference?;
    _image = snapshotData['image'] as String?;
    _units = castToType<int>(snapshotData['units']);
    _forSale = snapshotData['for_sale'] as bool?;
    _title = snapshotData['title'] as String?;
    _listingFilters = getDataList(snapshotData['listingFilters']);
    _sellerName = snapshotData['sellerName'] as String?;
    _unitType = snapshotData['unitType'] as String?;
    _produceType = snapshotData['produceType'] as bool?;
    _gardenType = snapshotData['gardenType'] as bool?;
    _location = snapshotData['location'] as LatLng?;
    _sellerImage = snapshotData['sellerImage'] as String?;
    _locationCity = snapshotData['locationCity'] as String?;
    _isArchived = snapshotData['isArchived'] as bool?;
    _psold = castToType<int>(snapshotData['psold']);
    _itemForm = snapshotData['itemForm'] as String?;
    _tempCondition = snapshotData['tempCondition'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('product');

  static Stream<ProductRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProductRecord.fromSnapshot(s));

  static Future<ProductRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProductRecord.fromSnapshot(s));

  static ProductRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProductRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProductRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProductRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ProductRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProductRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createProductRecordData({
  String? description,
  double? price,
  DateTime? createdAt,
  DateTime? modifiedAt,
  String? id,
  DocumentReference? seller,
  String? image,
  int? units,
  bool? forSale,
  String? title,
  String? sellerName,
  String? unitType,
  bool? produceType,
  bool? gardenType,
  LatLng? location,
  String? sellerImage,
  String? locationCity,
  bool? isArchived,
  int? psold,
  String? itemForm,
  String? tempCondition,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'description': description,
      'price': price,
      'created_at': createdAt,
      'modified_at': modifiedAt,
      'id': id,
      'seller': seller,
      'image': image,
      'units': units,
      'for_sale': forSale,
      'title': title,
      'sellerName': sellerName,
      'unitType': unitType,
      'produceType': produceType,
      'gardenType': gardenType,
      'location': location,
      'sellerImage': sellerImage,
      'locationCity': locationCity,
      'isArchived': isArchived,
      'psold': psold,
      'itemForm': itemForm,
      'tempCondition': tempCondition,
    }.withoutNulls,
  );

  return firestoreData;
}

class ProductRecordDocumentEquality implements Equality<ProductRecord> {
  const ProductRecordDocumentEquality();

  @override
  bool equals(ProductRecord? e1, ProductRecord? e2) {
    const listEquality = ListEquality();
    return e1?.description == e2?.description &&
        e1?.price == e2?.price &&
        e1?.createdAt == e2?.createdAt &&
        e1?.modifiedAt == e2?.modifiedAt &&
        e1?.id == e2?.id &&
        e1?.seller == e2?.seller &&
        e1?.image == e2?.image &&
        e1?.units == e2?.units &&
        e1?.forSale == e2?.forSale &&
        e1?.title == e2?.title &&
        listEquality.equals(e1?.listingFilters, e2?.listingFilters) &&
        e1?.sellerName == e2?.sellerName &&
        e1?.unitType == e2?.unitType &&
        e1?.produceType == e2?.produceType &&
        e1?.gardenType == e2?.gardenType &&
        e1?.location == e2?.location &&
        e1?.sellerImage == e2?.sellerImage &&
        e1?.locationCity == e2?.locationCity &&
        e1?.isArchived == e2?.isArchived &&
        e1?.psold == e2?.psold &&
        e1?.itemForm == e2?.itemForm &&
        e1?.tempCondition == e2?.tempCondition;
  }

  @override
  int hash(ProductRecord? e) => const ListEquality().hash([
        e?.description,
        e?.price,
        e?.createdAt,
        e?.modifiedAt,
        e?.id,
        e?.seller,
        e?.image,
        e?.units,
        e?.forSale,
        e?.title,
        e?.listingFilters,
        e?.sellerName,
        e?.unitType,
        e?.produceType,
        e?.gardenType,
        e?.location,
        e?.sellerImage,
        e?.locationCity,
        e?.isArchived,
        e?.psold,
        e?.itemForm,
        e?.tempCondition
      ]);

  @override
  bool isValidKey(Object? o) => o is ProductRecord;
}
