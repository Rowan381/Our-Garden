import 'package:flutter/material.dart';
import '../services/connectivity_service.dart';

/// Extension methods for BuildContext to handle connectivity
extension ConnectivityContext on BuildContext {
  /// Check if internet is available and show a snackbar if not
  /// Returns true if connected, false if not
  Future<bool> checkConnectivity({
    String offlineMessage = 'No internet connection available',
  }) async {
    final hasInternet = await ConnectivityService.hasInternet();

    if (!hasInternet && mounted) {
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.wifi_off, color: Colors.white, size: 16),
              const SizedBox(width: 8),
              Text(offlineMessage),
            ],
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }

    return hasInternet;
  }

  /// Show a snackbar specifically for network operations that failed
  void showNetworkErrorSnackBar({
    String message = 'Network operation failed. Please check your connection.',
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Flexible(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

/// Wrap async operations with connectivity checks
/// Usage:
/// await networkOperation(() async {
///   // Your network code here
/// }, context);
Future<T?> networkOperation<T>(
    Future<T> Function() operation, BuildContext context,
    {String offlineMessage =
        'This feature requires an internet connection'}) async {
  final hasInternet = await context.checkConnectivity(
    offlineMessage: offlineMessage,
  );

  if (!hasInternet) {
    return null;
  }

  try {
    return await operation();
  } catch (e) {
    if (context.mounted) {
      context.showNetworkErrorSnackBar(
        message: 'Operation failed: ${e.toString()}',
      );
    }
    return null;
  }
}
