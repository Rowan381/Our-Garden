import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import 'app/bindings/initial_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';
import 'core/config/env_config.dart';
import 'core/services/auth_service.dart';
import 'core/services/api_service.dart';

// Define environment values that will be used if .env file is not found
Map<String, String> fallbackEnv = {
  'APP_NAME': 'Our Garden',
  'APP_VERSION': '1.0.0',
  'ENVIRONMENT': 'development',

  // Firebase config - using values from google-services.json
  'FIREBASE_API_KEY': 'AIzaSyA_fsqdk-7eAQyAGv0Y-gl-s6QIytkuncM',
  'FIREBASE_PROJECT_ID': 'our-garden-d2dcf',
  'FIREBASE_MESSAGING_SENDER_ID': '921384333583',
  'FIREBASE_APP_ID': '1:921384333583:android:5058ef8ffb2e3d92c04e7a',

  // API Keys - Will need actual keys for production
  'OPENAI_API_KEY': 'dummy_openai_key',
  'KINDWISE_API_KEY': 'dummy_kindwise_key',
  'GOOGLE_MAPS_API_KEY': 'dummy_google_maps_key',
  'GEOAPIFY_API_KEY': 'dummy_geoapify_key',
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  try {
    await dotenv.load(fileName: '.env');
    print('Environment file loaded successfully');
  } catch (e) {
    print('Error loading .env file: $e');
    print('Creating and using a default .env file');

    try {
      // Create a .env file with default values
      final envFile = File('.env');
      final envContent =
          fallbackEnv.entries.map((e) => '${e.key}=${e.value}').join('\n');
      await envFile.writeAsString(envContent);

      // Load the newly created file
      await dotenv.load(fileName: '.env');
      print('Created and loaded default .env file');
    } catch (e2) {
      print('Failed to create default .env file: $e2');
      // As a last resort, use a direct approach
      // Initialize dotenv with minimal content
      dotenv.testLoad();
      // Add each fallback value
      fallbackEnv.forEach((key, value) {
        dotenv.env[key] = value;
      });
      print('Using fallback environment values directly');
    }
  } // Validate environment configuration
  try {
    EnvConfig.validate();
    EnvConfig.printConfig();
  } catch (e) {
    print('Environment configuration error: $e');
    // In production, you might want to exit the app here
  }

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize GetX services
  Get.put(AuthService());
  Get.put(ApiService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Static method to access instance from anywhere
  static MyApp of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<MyApp>()!;
  }

  // Method to set theme mode (referenced in flutter_flow_util.dart)
  void setThemeMode(ThemeMode mode) {
    // In GetX, use Get.changeThemeMode
    Get.changeThemeMode(mode);
  }

  // Methods for route management (referenced in flutter_flow_util.dart)
  String getRoute() {
    return Get.currentRoute;
  }

  List<String> getRouteStack() {
    return Get.routeTree.routes.map((route) => route.name).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: EnvConfig.appName,
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Localization
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],

      // Routing
      initialBinding: InitialBinding(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,

      // Default transitions
      defaultTransition: Transition.fadeIn,

      // Error handling
      onUnknownRoute: (settings) {
        return GetPageRoute(
          page: () => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
      },
    );
  }
}

// Placeholder views for other features (to be implemented)
class MarketplaceView extends StatelessWidget {
  const MarketplaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marketplace')),
      body: const Center(child: Text('Marketplace View - Coming Soon')),
    );
  }
}

class GardenView extends StatelessWidget {
  const GardenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Garden')),
      body: const Center(child: Text('Garden View - Coming Soon')),
    );
  }
}

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: const Center(child: Text('Chat View - Coming Soon')),
    );
  }
}

class GptView extends StatelessWidget {
  const GptView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPT')),
      body: const Center(child: Text('GPT View - Coming Soon')),
    );
  }
}
