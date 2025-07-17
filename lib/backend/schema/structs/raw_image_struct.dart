// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RawImageStruct extends FFFirebaseStruct {
  RawImageStruct({
    RawImageStruct? body,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _body = body,
        super(firestoreUtilData);

  // "body" field.
  RawImageStruct? _body;
  RawImageStruct get body => _body ?? RawImageStruct();
  set body(RawImageStruct? val) => _body = val;

  void updateBody(Function(RawImageStruct) updateFn) {
    updateFn(_body ??= RawImageStruct());
  }

  bool hasBody() => _body != null;

  static RawImageStruct fromMap(Map<String, dynamic> data) => RawImageStruct(
        body: data['body'] is RawImageStruct
            ? data['body']
            : RawImageStruct.maybeFromMap(data['body']),
      );

  static RawImageStruct? maybeFromMap(dynamic data) =>
      data is Map ? RawImageStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'body': _body?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'body': serializeParam(
          _body,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static RawImageStruct fromSerializableMap(Map<String, dynamic> data) =>
      RawImageStruct(
        body: deserializeStructParam(
          data['body'],
          ParamType.DataStruct,
          false,
          structBuilder: RawImageStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'RawImageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RawImageStruct && body == other.body;
  }

  @override
  int get hashCode => const ListEquality().hash([body]);
}

RawImageStruct createRawImageStruct({
  RawImageStruct? body,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RawImageStruct(
      body: body ?? (clearUnsetFields ? RawImageStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

RawImageStruct? updateRawImageStruct(
  RawImageStruct? rawImage, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    rawImage
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addRawImageStructData(
  Map<String, dynamic> firestoreData,
  RawImageStruct? rawImage,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (rawImage == null) {
    return;
  }
  if (rawImage.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && rawImage.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final rawImageData = getRawImageFirestoreData(rawImage, forFieldValue);
  final nestedData = rawImageData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = rawImage.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getRawImageFirestoreData(
  RawImageStruct? rawImage, [
  bool forFieldValue = false,
]) {
  if (rawImage == null) {
    return {};
  }
  final firestoreData = mapToFirestore(rawImage.toMap());

  // Handle nested data for "body" field.
  addRawImageStructData(
    firestoreData,
    rawImage.hasBody() ? rawImage.body : null,
    'body',
    forFieldValue,
  );

  // Add any Firestore field values
  rawImage.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRawImageListFirestoreData(
  List<RawImageStruct>? rawImages,
) =>
    rawImages?.map((e) => getRawImageFirestoreData(e, true)).toList() ?? [];
