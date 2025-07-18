import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  // API Keys
  static String get openAIApiKey => dotenv.env['OPENAI_API_KEY'] ?? '';
  static String get kindwiseApiKey => dotenv.env['KINDWISE_API_KEY'] ?? '';
  static String get googleMapsApiKey => dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
  static String get geoapifyApiKey => dotenv.env['GEOAPIFY_API_KEY'] ?? '';
  
  // Firebase Config
  static String get firebaseApiKey => dotenv.env['FIREBASE_API_KEY'] ?? '';
  static String get firebaseProjectId => dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  static String get firebaseMessagingSenderId => dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  static String get firebaseAppId => dotenv.env['FIREBASE_APP_ID'] ?? '';
  
  // App Configuration
  static String get appName => dotenv.env['APP_NAME'] ?? 'Our Garden';
  static String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';
  static bool get isProduction => dotenv.env['ENVIRONMENT'] == 'production';
  static bool get isDevelopment => dotenv.env['ENVIRONMENT'] == 'development';
  
  // API Endpoints
  static String get openAIEndpoint => 'https://api.openai.com/v1/chat/completions';
  static String get kindwiseEndpoint => 'https://plant.id/api/v3/identify';
  static String get geoapifyEndpoint => 'https://api.geoapify.com/v1/geocode/reverse';
  
  // Validation
  static void validate() {
    final requiredKeys = [
      'OPENAI_API_KEY',
      'KINDWISE_API_KEY',
      'GOOGLE_MAPS_API_KEY',
      'GEOAPIFY_API_KEY',
      'FIREBASE_API_KEY',
      'FIREBASE_PROJECT_ID',
      'FIREBASE_MESSAGING_SENDER_ID',
      'FIREBASE_APP_ID',
    ];
    
    final missingKeys = <String>[];
    
    for (final key in requiredKeys) {
      if (dotenv.env[key]?.isEmpty ?? true) {
        missingKeys.add(key);
      }
    }
    
    if (missingKeys.isNotEmpty) {
      throw Exception('Missing required environment variables: ${missingKeys.join(', ')}');
    }
  }
  
  // Debug info (only in development)
  static void printConfig() {
    if (isDevelopment) {
      print('=== Environment Configuration ===');
      print('Environment: ${dotenv.env['ENVIRONMENT']}');
      print('App Name: $appName');
      print('App Version: $appVersion');
      print('OpenAI API Key: ${openAIApiKey.isNotEmpty ? '✓ Set' : '✗ Missing'}');
      print('Kindwise API Key: ${kindwiseApiKey.isNotEmpty ? '✓ Set' : '✗ Missing'}');
      print('Google Maps API Key: ${googleMapsApiKey.isNotEmpty ? '✓ Set' : '✗ Missing'}');
      print('Geoapify API Key: ${geoapifyApiKey.isNotEmpty ? '✓ Set' : '✗ Missing'}');
      print('Firebase Config: ${firebaseApiKey.isNotEmpty ? '✓ Set' : '✗ Missing'}');
      print('================================');
    }
  }
} 