// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class PlantUploadStruct extends FFFirebaseStruct {
  PlantUploadStruct({
    String? name,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  static PlantUploadStruct fromMap(Map<String, dynamic> data) =>
      PlantUploadStruct(
        name: data['name'] as String?,
      );

  static PlantUploadStruct? maybeFromMap(dynamic data) => data is Map
      ? PlantUploadStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
      }.withoutNulls;

  static PlantUploadStruct fromSerializableMap(Map<String, dynamic> data) =>
      PlantUploadStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PlantUploadStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PlantUploadStruct && name == other.name;
  }

  @override
  int get hashCode => const ListEquality().hash([name]);
}

PlantUploadStruct createPlantUploadStruct({
  String? name,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PlantUploadStruct(
      name: name,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PlantUploadStruct? updatePlantUploadStruct(
  PlantUploadStruct? plantUpload, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    plantUpload
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPlantUploadStructData(
  Map<String, dynamic> firestoreData,
  PlantUploadStruct? plantUpload,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (plantUpload == null) {
    return;
  }
  if (plantUpload.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && plantUpload.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final plantUploadData =
      getPlantUploadFirestoreData(plantUpload, forFieldValue);
  final nestedData =
      plantUploadData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = plantUpload.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPlantUploadFirestoreData(
  PlantUploadStruct? plantUpload, [
  bool forFieldValue = false,
]) {
  if (plantUpload == null) {
    return {};
  }
  final firestoreData = mapToFirestore(plantUpload.toMap());

  // Add any Firestore field values
  plantUpload.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPlantUploadListFirestoreData(
  List<PlantUploadStruct>? plantUploads,
) =>
    plantUploads?.map((e) => getPlantUploadFirestoreData(e, true)).toList() ??
    [];
