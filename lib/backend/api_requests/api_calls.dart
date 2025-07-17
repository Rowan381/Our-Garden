import 'dart:convert';
import '../cloud_functions/cloud_functions.dart';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Stripe Group Code

class StripeGroup {
  static RetrieveAccountInfoCall retrieveAccountInfoCall =
      RetrieveAccountInfoCall();
  static RetrieveSessionCall retrieveSessionCall = RetrieveSessionCall();
  static AccountsCall accountsCall = AccountsCall();
  static CreateAccountLinkCall createAccountLinkCall = CreateAccountLinkCall();
  static SessionsCall sessionsCall = SessionsCall();
}

class RetrieveAccountInfoCall {
  Future<ApiCallResponse> call({
    String? accountID = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'RetrieveAccountInfoCall',
        'variables': {
          'accountID': accountID,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  bool? chargesEnabled(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.charges_enabled''',
      ));
}

class RetrieveSessionCall {
  Future<ApiCallResponse> call({
    String? sessionID = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'RetrieveSessionCall',
        'variables': {
          'sessionID': sessionID,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  String? paymentStatus(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.payment_status''',
      ));
}

class AccountsCall {
  Future<ApiCallResponse> call({
    String? businessType = '',
    String? type = 'standard',
    String? country = '',
    String? email = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'AccountsCall',
        'variables': {
          'businessType': businessType,
          'type': type,
          'country': country,
          'email': email,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
}

class CreateAccountLinkCall {
  Future<ApiCallResponse> call({
    String? account = '',
    String? type = '',
    String? refreshUrl = '',
    String? returnUrl = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CreateAccountLinkCall',
        'variables': {
          'account': account,
          'type': type,
          'refreshUrl': refreshUrl,
          'returnUrl': returnUrl,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  String? url(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.url''',
      ));
}

class SessionsCall {
  Future<ApiCallResponse> call({
    String? connectedAcct = '',
    String? cancelURL = '',
    String? successURL = '',
    String? currency = '',
    String? productName = '',
    int? pricePerUnit,
    int? quantity,
    int? stripeFee,
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'SessionsCall',
        'variables': {
          'connectedAcct': connectedAcct,
          'cancelURL': cancelURL,
          'successURL': successURL,
          'currency': currency,
          'productName': productName,
          'pricePerUnit': pricePerUnit,
          'quantity': quantity,
          'stripeFee': stripeFee,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
  String? url(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.url''',
      ));
}

/// End Stripe Group Code

/// Start KindWiseAPI Group Code

class KindWiseAPIGroup {
  static String getBaseUrl({
    String? key = '',
  }) =>
      'https://plant.id/api/v3';
  static Map<String, String> headers = {
    'Api-Key': '[key]',
  };
  static ThreadkindwiseCall threadkindwiseCall = ThreadkindwiseCall();
  static RetrieveIDCall retrieveIDCall = RetrieveIDCall();
  static MessageskindwiseCall messageskindwiseCall = MessageskindwiseCall();
  static PlantIDCall plantIDCall = PlantIDCall();
}

class ThreadkindwiseCall {
  Future<ApiCallResponse> call({
    String? key = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ThreadkindwiseCall',
        'variables': {
          'key': key,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class RetrieveIDCall {
  Future<ApiCallResponse> call({
    String? accessToken = '',
    String? key = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'RetrieveIDCall',
        'variables': {
          'accessToken': accessToken,
          'key': key,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class MessageskindwiseCall {
  Future<ApiCallResponse> call({
    String? key = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'MessageskindwiseCall',
        'variables': {
          'key': key,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class PlantIDCall {
  Future<ApiCallResponse> call({
    List<String>? imagesList,
    String? health = 'auto',
    String? key = '',
  }) async {
    final images = _serializeList(imagesList);

    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'PlantIDCall',
        'variables': {
          'images': images,
          'health': health,
          'key': key,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

/// End KindWiseAPI Group Code

/// Start OpenAI ChatGPT Group Code

class OpenAIChatGPTGroup {
  static RunCall runCall = RunCall();
  static RetrieverunCall retrieverunCall = RetrieverunCall();
  static MessageCall messageCall = MessageCall();
  static ThreadsCall threadsCall = ThreadsCall();
  static MessagesCall messagesCall = MessagesCall();
}

class RunCall {
  Future<ApiCallResponse> call({
    String? threadId = 'thread_UnPL9VqoSR3Rc7NV20Eqx0Hb',
    String? assistantId = 'asst_AOnZd6xIci0RIUmI7UD9JzzT',
    String? additionalInstructions = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'RunCall',
        'variables': {
          'threadId': threadId,
          'assistantId': assistantId,
          'additionalInstructions': additionalInstructions,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  String? runId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
}

class RetrieverunCall {
  Future<ApiCallResponse> call({
    String? threadId = 'thread_mqxytLu44TfodPWY9qdO41WV',
    String? runId = 'run_T6edWozxLK3VwP8MojNhiqPQ',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'RetrieverunCall',
        'variables': {
          'threadId': threadId,
          'runId': runId,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  String? status(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.status''',
      ));
}

class MessageCall {
  Future<ApiCallResponse> call({
    String? threadId = 'thread_J0806ybXSnF3N1gIqDIKb4FU',
    String? content = '\"Hello Sage!\"',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'MessageCall',
        'variables': {
          'threadId': threadId,
          'content': content,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ThreadsCall {
  Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'ThreadsCall',
        'variables': {
          'token': token,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  String? threadid(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
}

class MessagesCall {
  Future<ApiCallResponse> call({
    String? threadId = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'MessagesCall',
        'variables': {
          'threadId': threadId,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data[0].content[0]''',
      );
  List<ChatMessageStruct>? messagesList(dynamic response) => (getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => ChatMessageStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
}

/// End OpenAI ChatGPT Group Code

class LatLongReverseGeoCall {
  static Future<ApiCallResponse> call({
    double? latitude,
    double? longitude,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'LatLongReverseGeo',
      apiUrl:
          'https://api.geoapify.com/v1/geocode/reverse?lat=${latitude}&lon=${longitude}&apiKey=e7a88d03a2c04ecc82d9c003cce8f649',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'Latitude': latitude,
        'Longitude': longitude,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? city(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.features[:].properties.city''',
      ));
}

class OpenWeatherOneCallCall {
  static Future<ApiCallResponse> call({
    double? latitude,
    double? longitude,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'OpenWeatherOneCall',
      apiUrl:
          'https://api.openweathermap.org/data/3.0/onecall?lat=${latitude}&lon=${longitude}&appid=82ec42d74c8c4210ad170ad3c8194918',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'Latitude': latitude,
        'Longitude': longitude,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? weather(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$["current"]["weather"][0]["description"]''',
      ));
}

class OpenaiUploadFileCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    FFUploadedFile? file,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Openai Upload File',
      apiUrl: 'https://api.openai.com/v1/files',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'multipart/form-data',
      },
      params: {
        'file': file,
        'purpose': "assistants",
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic fileID(dynamic response) => getJsonField(
        response,
        r'''$.id''',
      );
}

class StripeTroubleshootCall {
  static Future<ApiCallResponse> call({
    String? email = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'StripeTroubleshootCall',
        'variables': {
          'email': email,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
