/// Comprehensive error reporting and handling utilities
/// This provides centralized error handling, logging, and user feedback mechanisms.

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum ErrorSeverity {
  low, // Minor issues that don't affect core functionality
  medium, // Issues that affect some functionality but app remains usable
  high, // Critical issues that significantly impact user experience
  critical, // Fatal errors that might crash the app
}

enum ErrorCategory {
  authentication,
  firestore,
  network,
  ui,
  initialization,
  permissions,
  memory,
  unknown,
}

class AppError {
  final String message;
  final ErrorSeverity severity;
  final ErrorCategory category;
  final String? technicalDetails;
  final StackTrace? stackTrace;
  final DateTime timestamp;
  final String? userAction;

  AppError({
    required this.message,
    required this.severity,
    required this.category,
    this.technicalDetails,
    this.stackTrace,
    this.userAction,
  }) : timestamp = DateTime.now();

  @override
  String toString() {
    return 'AppError(${category.name}): $message';
  }

  String get logMessage {
    final buffer = StringBuffer();
    buffer.writeln(
        '🔥 [${severity.name.toUpperCase()}] ${category.name.toUpperCase()}: $message');
    if (technicalDetails != null) {
      buffer.writeln('   Technical: $technicalDetails');
    }
    if (userAction != null) {
      buffer.writeln('   User Action: $userAction');
    }
    buffer.writeln('   Timestamp: ${timestamp.toIso8601String()}');
    if (stackTrace != null) {
      buffer.writeln('   Stack Trace: $stackTrace');
    }
    return buffer.toString();
  }
}

class ErrorReporter {
  static final List<AppError> _errorHistory = [];
  static const int maxErrorHistory = 100;

  /// ✅ Report an error with proper categorization
  static void reportError(AppError error) {
    // Add to history
    _errorHistory.add(error);
    if (_errorHistory.length > maxErrorHistory) {
      _errorHistory.removeAt(0);
    }

    // Log based on severity
    switch (error.severity) {
      case ErrorSeverity.low:
        debugPrint('💛 ${error.logMessage}');
        break;
      case ErrorSeverity.medium:
        debugPrint('🧡 ${error.logMessage}');
        break;
      case ErrorSeverity.high:
        debugPrint('❤️ ${error.logMessage}');
        break;
      case ErrorSeverity.critical:
        debugPrint('💀 ${error.logMessage}');
        break;
    }

    // TODO: Send to crash reporting service (Firebase Crashlytics, Sentry, etc.)
    // _sendToCrashReporting(error);
  }

  /// ✅ Quick error reporting methods for common scenarios
  static void reportFirestoreError(String operation, dynamic error,
      {String? userAction}) {
    String message = 'Firestore operation failed: $operation';
    String? technicalDetails;
    ErrorSeverity severity = ErrorSeverity.medium;

    if (error.toString().contains('permission-denied')) {
      message = 'Permission denied for Firestore operation: $operation';
      technicalDetails = 'Check Firestore security rules';
      severity = ErrorSeverity.high;
    } else if (error.toString().contains('unavailable')) {
      message = 'Firestore service temporarily unavailable';
      technicalDetails = 'Network or service issue';
      severity = ErrorSeverity.medium;
    }

    reportError(AppError(
      message: message,
      severity: severity,
      category: ErrorCategory.firestore,
      technicalDetails: technicalDetails ?? error.toString(),
      userAction: userAction,
    ));
  }

  static void reportNetworkError(String operation, dynamic error,
      {String? userAction}) {
    reportError(AppError(
      message: 'Network error during $operation',
      severity: ErrorSeverity.medium,
      category: ErrorCategory.network,
      technicalDetails: error.toString(),
      userAction: userAction,
    ));
  }

  static void reportAuthError(String operation, dynamic error,
      {String? userAction}) {
    reportError(AppError(
      message: 'Authentication error during $operation',
      severity: ErrorSeverity.high,
      category: ErrorCategory.authentication,
      technicalDetails: error.toString(),
      userAction: userAction,
    ));
  }

  static void reportUIError(String component, dynamic error,
      {String? userAction}) {
    reportError(AppError(
      message: 'UI error in $component',
      severity: ErrorSeverity.low,
      category: ErrorCategory.ui,
      technicalDetails: error.toString(),
      userAction: userAction,
    ));
  }

  static void reportMemoryError(String operation, dynamic error,
      {String? userAction}) {
    reportError(AppError(
      message: 'Memory allocation error during $operation',
      severity: ErrorSeverity.high,
      category: ErrorCategory.memory,
      technicalDetails: error.toString(),
      userAction: userAction,
    ));
  }

  static void reportInitializationError(String service, dynamic error,
      {String? userAction}) {
    reportError(AppError(
      message: 'Failed to initialize $service',
      severity: ErrorSeverity.critical,
      category: ErrorCategory.initialization,
      technicalDetails: error.toString(),
      userAction: userAction,
    ));
  }

  /// ✅ Get error history for debugging
  static List<AppError> get errorHistory => List.unmodifiable(_errorHistory);

  /// ✅ Get errors by category
  static List<AppError> getErrorsByCategory(ErrorCategory category) {
    return _errorHistory.where((error) => error.category == category).toList();
  }

  /// ✅ Get errors by severity
  static List<AppError> getErrorsBySeverity(ErrorSeverity severity) {
    return _errorHistory.where((error) => error.severity == severity).toList();
  }

  /// ✅ Clear error history
  static void clearErrorHistory() {
    _errorHistory.clear();
  }

  /// ✅ Generate error summary for debugging
  static String generateErrorSummary() {
    if (_errorHistory.isEmpty) {
      return 'No errors recorded.';
    }

    final buffer = StringBuffer();
    buffer.writeln('Error Summary (${_errorHistory.length} total errors)');
    buffer.writeln('==============================================');

    // Group by category
    final groupedErrors = <ErrorCategory, List<AppError>>{};
    for (final error in _errorHistory) {
      groupedErrors.putIfAbsent(error.category, () => []).add(error);
    }

    for (final category in groupedErrors.keys) {
      final errors = groupedErrors[category]!;
      buffer.writeln(
          '\n${category.name.toUpperCase()} (${errors.length} errors):');
      for (final error in errors.take(5)) {
        // Show only first 5 errors per category
        buffer.writeln('  - ${error.message} (${error.severity.name})');
      }
      if (errors.length > 5) {
        buffer.writeln('  ... and ${errors.length - 5} more');
      }
    }

    return buffer.toString();
  }
}

/// ✅ User-friendly error display widgets
class ErrorDisplayWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;
  final IconData? icon;
  final Color? color;

  const ErrorDisplayWidget({
    Key? key,
    required this.title,
    required this.message,
    this.onRetry,
    this.onDismiss,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (color ?? Colors.red).withOpacity(0.1),
        border: Border.all(color: color ?? Colors.red, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon ?? Icons.error_outline, color: color ?? Colors.red),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color ?? Colors.red,
                  ),
                ),
              ),
              if (onDismiss != null)
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: onDismiss,
                  color: Colors.grey,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(color: Colors.grey[700]),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: color ?? Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// ✅ Snackbar for quick error notifications
class ErrorSnackBar {
  static void show(
    BuildContext context,
    String message, {
    ErrorSeverity severity = ErrorSeverity.medium,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    Color backgroundColor;
    IconData icon;

    switch (severity) {
      case ErrorSeverity.low:
        backgroundColor = Colors.orange;
        icon = Icons.warning_amber;
        break;
      case ErrorSeverity.medium:
        backgroundColor = Colors.deepOrange;
        icon = Icons.error_outline;
        break;
      case ErrorSeverity.high:
        backgroundColor = Colors.red;
        icon = Icons.error;
        break;
      case ErrorSeverity.critical:
        backgroundColor = Colors.red[900]!;
        icon = Icons.dangerous;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: onAction != null && actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: Colors.white,
                onPressed: onAction,
              )
            : null,
      ),
    );
  }
}

/// ✅ Global error boundary widget
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(FlutterErrorDetails)? errorWidgetBuilder;

  const ErrorBoundary({
    Key? key,
    required this.child,
    this.errorWidgetBuilder,
  }) : super(key: key);

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  FlutterErrorDetails? _errorDetails;

  @override
  void initState() {
    super.initState();

    // Capture errors that occur in this widget subtree
    FlutterError.onError = (FlutterErrorDetails details) {
      setState(() {
        _errorDetails = details;
      });

      ErrorReporter.reportError(AppError(
        message: 'Widget error: ${details.exception}',
        severity: ErrorSeverity.high,
        category: ErrorCategory.ui,
        technicalDetails: details.toString(),
        stackTrace: details.stack,
      ));
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_errorDetails != null) {
      return widget.errorWidgetBuilder?.call(_errorDetails!) ??
          ErrorDisplayWidget(
            title: 'Something went wrong',
            message: 'A technical error occurred. Please try again.',
            onRetry: () {
              setState(() {
                _errorDetails = null;
              });
            },
          );
    }

    return widget.child;
  }
}
