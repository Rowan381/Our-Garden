import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/env_config.dart';

class ApiService extends GetxService {
  static ApiService get to => Get.find();
  
  final http.Client _httpClient = http.Client();
  
  // Generic API call method
  Future<Map<String, dynamic>> makeApiCall({
    required String endpoint,
    required Map<String, dynamic> data,
    String? apiKey,
    Map<String, String>? additionalHeaders,
    String method = 'POST',
  }) async {
    try {
      final headers = <String, String>{
        'Content-Type': 'application/json',
        if (apiKey != null) 'Authorization': 'Bearer $apiKey',
        if (apiKey != null) 'Api-Key': apiKey,
        ...?additionalHeaders,
      };
      
      http.Response response;
      
      switch (method.toUpperCase()) {
        case 'GET':
          final uri = Uri.parse(endpoint).replace(queryParameters: data.map((k, v) => MapEntry(k, v.toString())));
          response = await _httpClient.get(uri, headers: headers);
          break;
        case 'POST':
          response = await _httpClient.post(
            Uri.parse(endpoint),
            headers: headers,
            body: jsonEncode(data),
          );
          break;
        case 'PUT':
          response = await _httpClient.put(
            Uri.parse(endpoint),
            headers: headers,
            body: jsonEncode(data),
          );
          break;
        case 'DELETE':
          response = await _httpClient.delete(
            Uri.parse(endpoint),
            headers: headers,
            body: jsonEncode(data),
          );
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('API call failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  // OpenAI API calls
  Future<Map<String, dynamic>> callOpenAI({
    required String prompt,
    String model = 'gpt-3.5-turbo',
    double temperature = 0.7,
    int maxTokens = 1000,
  }) async {
    final data = {
      'model': model,
      'messages': [
        {'role': 'user', 'content': prompt}
      ],
      'temperature': temperature,
      'max_tokens': maxTokens,
    };
    
    return await makeApiCall(
      endpoint: EnvConfig.openAIEndpoint,
      data: data,
      apiKey: EnvConfig.openAIApiKey,
    );
  }
  
  // Kindwise Plant Identification API
  Future<Map<String, dynamic>> callKindwise({
    required List<String> imageUrls,
    String health = 'auto',
  }) async {
    final data = {
      'images': imageUrls,
      'health': health,
    };
    
    return await makeApiCall(
      endpoint: EnvConfig.kindwiseEndpoint,
      data: data,
      apiKey: EnvConfig.kindwiseApiKey,
    );
  }
  
  // Geoapify Geocoding API
  Future<Map<String, dynamic>> callGeoapify({
    required double latitude,
    required double longitude,
  }) async {
    final data = {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'apiKey': EnvConfig.geoapifyApiKey,
    };
    
    return await makeApiCall(
      endpoint: EnvConfig.geoapifyEndpoint,
      data: data,
      method: 'GET',
    );
  }
  
  // Stripe API calls (via cloud functions)
  Future<Map<String, dynamic>> callStripe({
    required String callName,
    required Map<String, dynamic> variables,
  }) async {
    // This would typically call your Firebase Cloud Function
    // For now, we'll return a placeholder
    return {
      'success': true,
      'callName': callName,
      'variables': variables,
    };
  }
  
  @override
  void onClose() {
    _httpClient.close();
    super.onClose();
  }
} 