// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatMessageStruct extends FFFirebaseStruct {
  ChatMessageStruct({
    String? id,
    String? object,
    int? createdAt,
    String? assistantId,
    String? threadId,
    String? runId,
    String? role,
    List<ContentStruct>? content,
    List<String>? attachments,
    MetadataStruct? metadata,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _object = object,
        _createdAt = createdAt,
        _assistantId = assistantId,
        _threadId = threadId,
        _runId = runId,
        _role = role,
        _content = content,
        _attachments = attachments,
        _metadata = metadata,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "object" field.
  String? _object;
  String get object => _object ?? '';
  set object(String? val) => _object = val;

  bool hasObject() => _object != null;

  // "created_at" field.
  int? _createdAt;
  int get createdAt => _createdAt ?? 0;
  set createdAt(int? val) => _createdAt = val;

  void incrementCreatedAt(int amount) => createdAt = createdAt + amount;

  bool hasCreatedAt() => _createdAt != null;

  // "assistant_id" field.
  String? _assistantId;
  String get assistantId => _assistantId ?? '';
  set assistantId(String? val) => _assistantId = val;

  bool hasAssistantId() => _assistantId != null;

  // "thread_id" field.
  String? _threadId;
  String get threadId => _threadId ?? '';
  set threadId(String? val) => _threadId = val;

  bool hasThreadId() => _threadId != null;

  // "run_id" field.
  String? _runId;
  String get runId => _runId ?? '';
  set runId(String? val) => _runId = val;

  bool hasRunId() => _runId != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  set role(String? val) => _role = val;

  bool hasRole() => _role != null;

  // "content" field.
  List<ContentStruct>? _content;
  List<ContentStruct> get content => _content ?? const [];
  set content(List<ContentStruct>? val) => _content = val;

  void updateContent(Function(List<ContentStruct>) updateFn) {
    updateFn(_content ??= []);
  }

  bool hasContent() => _content != null;

  // "attachments" field.
  List<String>? _attachments;
  List<String> get attachments => _attachments ?? const [];
  set attachments(List<String>? val) => _attachments = val;

  void updateAttachments(Function(List<String>) updateFn) {
    updateFn(_attachments ??= []);
  }

  bool hasAttachments() => _attachments != null;

  // "metadata" field.
  MetadataStruct? _metadata;
  MetadataStruct get metadata => _metadata ?? MetadataStruct();
  set metadata(MetadataStruct? val) => _metadata = val;

  void updateMetadata(Function(MetadataStruct) updateFn) {
    updateFn(_metadata ??= MetadataStruct());
  }

  bool hasMetadata() => _metadata != null;

  static ChatMessageStruct fromMap(Map<String, dynamic> data) =>
      ChatMessageStruct(
        id: data['id'] as String?,
        object: data['object'] as String?,
        createdAt: castToType<int>(data['created_at']),
        assistantId: data['assistant_id'] as String?,
        threadId: data['thread_id'] as String?,
        runId: data['run_id'] as String?,
        role: data['role'] as String?,
        content: getStructList(
          data['content'],
          ContentStruct.fromMap,
        ),
        attachments: getDataList(data['attachments']),
        metadata: data['metadata'] is MetadataStruct
            ? data['metadata']
            : MetadataStruct.maybeFromMap(data['metadata']),
      );

  static ChatMessageStruct? maybeFromMap(dynamic data) => data is Map
      ? ChatMessageStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'object': _object,
        'created_at': _createdAt,
        'assistant_id': _assistantId,
        'thread_id': _threadId,
        'run_id': _runId,
        'role': _role,
        'content': _content?.map((e) => e.toMap()).toList(),
        'attachments': _attachments,
        'metadata': _metadata?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'object': serializeParam(
          _object,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.int,
        ),
        'assistant_id': serializeParam(
          _assistantId,
          ParamType.String,
        ),
        'thread_id': serializeParam(
          _threadId,
          ParamType.String,
        ),
        'run_id': serializeParam(
          _runId,
          ParamType.String,
        ),
        'role': serializeParam(
          _role,
          ParamType.String,
        ),
        'content': serializeParam(
          _content,
          ParamType.DataStruct,
          isList: true,
        ),
        'attachments': serializeParam(
          _attachments,
          ParamType.String,
          isList: true,
        ),
        'metadata': serializeParam(
          _metadata,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static ChatMessageStruct fromSerializableMap(Map<String, dynamic> data) =>
      ChatMessageStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        object: deserializeParam(
          data['object'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.int,
          false,
        ),
        assistantId: deserializeParam(
          data['assistant_id'],
          ParamType.String,
          false,
        ),
        threadId: deserializeParam(
          data['thread_id'],
          ParamType.String,
          false,
        ),
        runId: deserializeParam(
          data['run_id'],
          ParamType.String,
          false,
        ),
        role: deserializeParam(
          data['role'],
          ParamType.String,
          false,
        ),
        content: deserializeStructParam<ContentStruct>(
          data['content'],
          ParamType.DataStruct,
          true,
          structBuilder: ContentStruct.fromSerializableMap,
        ),
        attachments: deserializeParam<String>(
          data['attachments'],
          ParamType.String,
          true,
        ),
        metadata: deserializeStructParam(
          data['metadata'],
          ParamType.DataStruct,
          false,
          structBuilder: MetadataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ChatMessageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ChatMessageStruct &&
        id == other.id &&
        object == other.object &&
        createdAt == other.createdAt &&
        assistantId == other.assistantId &&
        threadId == other.threadId &&
        runId == other.runId &&
        role == other.role &&
        listEquality.equals(content, other.content) &&
        listEquality.equals(attachments, other.attachments) &&
        metadata == other.metadata;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        object,
        createdAt,
        assistantId,
        threadId,
        runId,
        role,
        content,
        attachments,
        metadata
      ]);
}

ChatMessageStruct createChatMessageStruct({
  String? id,
  String? object,
  int? createdAt,
  String? assistantId,
  String? threadId,
  String? runId,
  String? role,
  MetadataStruct? metadata,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ChatMessageStruct(
      id: id,
      object: object,
      createdAt: createdAt,
      assistantId: assistantId,
      threadId: threadId,
      runId: runId,
      role: role,
      metadata: metadata ?? (clearUnsetFields ? MetadataStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ChatMessageStruct? updateChatMessageStruct(
  ChatMessageStruct? chatMessage, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    chatMessage
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addChatMessageStructData(
  Map<String, dynamic> firestoreData,
  ChatMessageStruct? chatMessage,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (chatMessage == null) {
    return;
  }
  if (chatMessage.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && chatMessage.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final chatMessageData =
      getChatMessageFirestoreData(chatMessage, forFieldValue);
  final nestedData =
      chatMessageData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = chatMessage.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getChatMessageFirestoreData(
  ChatMessageStruct? chatMessage, [
  bool forFieldValue = false,
]) {
  if (chatMessage == null) {
    return {};
  }
  final firestoreData = mapToFirestore(chatMessage.toMap());

  // Handle nested data for "metadata" field.
  addMetadataStructData(
    firestoreData,
    chatMessage.hasMetadata() ? chatMessage.metadata : null,
    'metadata',
    forFieldValue,
  );

  // Add any Firestore field values
  chatMessage.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getChatMessageListFirestoreData(
  List<ChatMessageStruct>? chatMessages,
) =>
    chatMessages?.map((e) => getChatMessageFirestoreData(e, true)).toList() ??
    [];
