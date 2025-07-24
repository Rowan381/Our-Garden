import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final Connectivity _connectivity = Connectivity();
  static final StreamController<bool> _controller =
      StreamController<bool>.broadcast();
  static bool _initialized = false;

  // Stream that broadcasts connectivity status (true = connected, false = disconnected)
  static Stream<bool> get connectivityStream => _controller.stream;

  // Initialize the connectivity service and start listening for changes
  static void initialize() {
    if (_initialized) return;

    _initialized = true;

    // Listen for connectivity changes
    _connectivity.onConnectivityChanged.listen((result) {
      final isConnected = result != ConnectivityResult.none;
      _controller.add(isConnected);
    });

    // Check initial state
    checkConnectivity();
  }

  // Check current connectivity and broadcast the result
  static Future<void> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    final isConnected = result != ConnectivityResult.none;
    _controller.add(isConnected);
  }

  // Simple method to check if internet is available
  static Future<bool> hasInternet() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  // Clean up resources
  static void dispose() {
    if (!_controller.isClosed) {
      _controller.close();
    }
    _initialized = false;
  }
}
