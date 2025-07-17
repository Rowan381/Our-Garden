// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FileAttachmentStruct extends FFFirebaseStruct {
  FileAttachmentStruct({
    String? fileId,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _fileId = fileId,
        super(firestoreUtilData);

  // "file_id" field.
  String? _fileId;
  String get fileId => _fileId ?? '';
  set fileId(String? val) => _fileId = val;

  bool hasFileId() => _fileId != null;

  static FileAttachmentStruct fromMap(Map<String, dynamic> data) =>
      FileAttachmentStruct(
        fileId: data['file_id'] as String?,
      );

  static FileAttachmentStruct? maybeFromMap(dynamic data) => data is Map
      ? FileAttachmentStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'file_id': _fileId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'file_id': serializeParam(
          _fileId,
          ParamType.String,
        ),
      }.withoutNulls;

  static FileAttachmentStruct fromSerializableMap(Map<String, dynamic> data) =>
      FileAttachmentStruct(
        fileId: deserializeParam(
          data['file_id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'FileAttachmentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FileAttachmentStruct && fileId == other.fileId;
  }

  @override
  int get hashCode => const ListEquality().hash([fileId]);
}

FileAttachmentStruct createFileAttachmentStruct({
  String? fileId,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FileAttachmentStruct(
      fileId: fileId,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FileAttachmentStruct? updateFileAttachmentStruct(
  FileAttachmentStruct? fileAttachment, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    fileAttachment
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFileAttachmentStructData(
  Map<String, dynamic> firestoreData,
  FileAttachmentStruct? fileAttachment,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (fileAttachment == null) {
    return;
  }
  if (fileAttachment.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && fileAttachment.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final fileAttachmentData =
      getFileAttachmentFirestoreData(fileAttachment, forFieldValue);
  final nestedData =
      fileAttachmentData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = fileAttachment.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFileAttachmentFirestoreData(
  FileAttachmentStruct? fileAttachment, [
  bool forFieldValue = false,
]) {
  if (fileAttachment == null) {
    return {};
  }
  final firestoreData = mapToFirestore(fileAttachment.toMap());

  // Add any Firestore field values
  fileAttachment.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFileAttachmentListFirestoreData(
  List<FileAttachmentStruct>? fileAttachments,
) =>
    fileAttachments
        ?.map((e) => getFileAttachmentFirestoreData(e, true))
        .toList() ??
    [];
