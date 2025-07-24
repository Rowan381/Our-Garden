/// Safe layout wrapper to prevent RenderBox layout assertion errors
/// This widget provides safe constraints and error boundaries for complex layouts

import 'package:flutter/material.dart';
import '../utils/error_reporter.dart';

class SafeLayoutWrapper extends StatelessWidget {
  final Widget child;
  final String debugLabel;
  final double? minHeight;
  final double? maxHeight;
  final EdgeInsets? padding;
  final bool enableScrolling;

  const SafeLayoutWrapper({
    Key? key,
    required this.child,
    this.debugLabel = 'SafeLayoutWrapper',
    this.minHeight,
    this.maxHeight,
    this.padding,
    this.enableScrolling = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        try {
          Widget content = child;

          // Apply padding if specified
          if (padding != null) {
            content = Padding(padding: padding!, child: content);
          }

          // Apply scrolling if enabled
          if (enableScrolling) {
            content = SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: content,
            );
          }

          // Apply height constraints if specified
          if (minHeight != null || maxHeight != null) {
            content = ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: minHeight ?? 0,
                maxHeight: maxHeight ?? constraints.maxHeight,
              ),
              child: content,
            );
          }

          return content;
        } catch (e) {
          // Report layout errors
          ErrorReporter.reportUIError(
            'SafeLayoutWrapper ($debugLabel)',
            e,
            userAction: 'Rendering safe layout wrapper',
          );

          // Return error fallback
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning, size: 48, color: Colors.orange),
                SizedBox(height: 8),
                Text(
                  'Layout Error',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Unable to render $debugLabel',
                  style: TextStyle(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

/// Safe Column widget that prevents layout assertion errors
class SafeColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final String debugLabel;

  const SafeColumn({
    Key? key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.debugLabel = 'SafeColumn',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeLayoutWrapper(
      debugLabel: debugLabel,
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children:
            children.map((child) => _SafeChildWrapper(child: child)).toList(),
      ),
    );
  }
}

/// Safe Row widget that prevents layout assertion errors
class SafeRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final String debugLabel;

  const SafeRow({
    Key? key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.debugLabel = 'SafeRow',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeLayoutWrapper(
      debugLabel: debugLabel,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children:
            children.map((child) => _SafeChildWrapper(child: child)).toList(),
      ),
    );
  }
}

/// Safe Expanded widget with error handling
class SafeExpanded extends StatelessWidget {
  final Widget child;
  final int flex;
  final String debugLabel;

  const SafeExpanded({
    Key? key,
    required this.child,
    this.flex = 1,
    this.debugLabel = 'SafeExpanded',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return Expanded(
        flex: flex,
        child: _SafeChildWrapper(child: child),
      );
    } catch (e) {
      ErrorReporter.reportUIError(
        'SafeExpanded ($debugLabel)',
        e,
        userAction: 'Rendering expanded widget',
      );

      return Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          'Layout Error in $debugLabel',
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
      );
    }
  }
}

/// Safe Flexible widget with error handling
class SafeFlexible extends StatelessWidget {
  final Widget child;
  final int flex;
  final FlexFit fit;
  final String debugLabel;

  const SafeFlexible({
    Key? key,
    required this.child,
    this.flex = 1,
    this.fit = FlexFit.loose,
    this.debugLabel = 'SafeFlexible',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return Flexible(
        flex: flex,
        fit: fit,
        child: _SafeChildWrapper(child: child),
      );
    } catch (e) {
      ErrorReporter.reportUIError(
        'SafeFlexible ($debugLabel)',
        e,
        userAction: 'Rendering flexible widget',
      );

      return Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          'Layout Error in $debugLabel',
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
      );
    }
  }
}

/// Internal wrapper for child widgets to catch individual widget errors
class _SafeChildWrapper extends StatelessWidget {
  final Widget child;

  const _SafeChildWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        try {
          return child;
        } catch (e) {
          return Container(
            padding: const EdgeInsets.all(4),
            child: Icon(Icons.error_outline, size: 16, color: Colors.red),
          );
        }
      },
    );
  }
}

/// Safe Container with proper constraints
class SafeContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;
  final String debugLabel;

  const SafeContainer({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment,
    this.debugLabel = 'SafeContainer',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        try {
          // Ensure width and height don't exceed available space
          final safeWidth = width != null
              ? width! > constraints.maxWidth
                  ? constraints.maxWidth
                  : width
              : null;

          final safeHeight = height != null
              ? height! > constraints.maxHeight
                  ? constraints.maxHeight
                  : height
              : null;

          return Container(
            width: safeWidth,
            height: safeHeight,
            padding: padding,
            margin: margin,
            decoration: decoration,
            alignment: alignment,
            child: child != null ? _SafeChildWrapper(child: child!) : null,
          );
        } catch (e) {
          ErrorReporter.reportUIError(
            'SafeContainer ($debugLabel)',
            e,
            userAction: 'Rendering container widget',
          );

          return Container(
            width: 100,
            height: 50,
            color: Colors.red.withOpacity(0.1),
            child: Center(
              child: Text(
                'Error',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          );
        }
      },
    );
  }
}

/// Safe SingleChildScrollView wrapper
class SafeScrollView extends StatelessWidget {
  final Widget child;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final String debugLabel;

  const SafeScrollView({
    Key? key,
    required this.child,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
    this.debugLabel = 'SafeScrollView',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return SingleChildScrollView(
        scrollDirection: scrollDirection,
        physics: physics ?? const BouncingScrollPhysics(),
        padding: padding,
        child: _SafeChildWrapper(child: child),
      );
    } catch (e) {
      ErrorReporter.reportUIError(
        'SafeScrollView ($debugLabel)',
        e,
        userAction: 'Rendering scroll view',
      );

      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.error_outline, color: Colors.red),
            Text('Scroll Error', style: TextStyle(color: Colors.red)),
          ],
        ),
      );
    }
  }
}
