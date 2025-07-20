import 'package:flutter/material.dart';
import 'index.dart';

/// Example of how to integrate the MVC home page
///
/// This file demonstrates the proper way to use the MVC architecture
/// for the home page in your Flutter application.
///
/// Usage:
/// 1. Import this file or copy the pattern
/// 2. Use HomePageIntegrationExample in your app
/// 3. Follow the lifecycle management pattern shown below

class HomePageIntegrationExample extends StatefulWidget {
  const HomePageIntegrationExample({super.key});

  @override
  State<HomePageIntegrationExample> createState() =>
      _HomePageIntegrationExampleState();
}

class _HomePageIntegrationExampleState
    extends State<HomePageIntegrationExample> {
  HomePageController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  /// Initialize the MVC controller
  Future<void> _initializeController() async {
    _controller = HomePageController(context);

    try {
      await _controller!.initializePage();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error initializing home page controller: $e');
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading while controller initializes
    if (!_isInitialized || _controller == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Use the MVC HomePageView
    return const HomePageView();
  }

  /// Example of how to access controller data
  void _exampleControllerUsage() {
    if (_controller != null) {
      // Get user location
      final userLocation = _controller!.getUserLocation();
      debugPrint('User location: ${userLocation.displayLocation}');

      // Get today's tasks
      final tasks = _controller!.getTodaysTasks();
      debugPrint('Tasks count: ${tasks.length}');

      // Access raw data model
      final dataModel = _controller!.dataModel;
      debugPrint('Garden tasks: ${dataModel.userGardenTasks?.length}');
    }
  }
}

/// Alternative simple usage without additional state management
class SimpleHomePageUsage extends StatelessWidget {
  const SimpleHomePageUsage({super.key});

  @override
  Widget build(BuildContext context) {
    // Direct usage - the HomePageView manages its own controller internally
    return const HomePageView();
  }
}
