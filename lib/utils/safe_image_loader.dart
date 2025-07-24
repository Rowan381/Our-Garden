/// Safe image loading utilities to prevent graphics buffer allocation errors
/// This utility provides fallback mechanisms and proper error handling for image loading.

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SafeImageLoader {
  /// ✅ Safe network image with comprehensive error handling
  static Widget safeNetworkImage(
    String? imageUrl, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
    bool showLoadingIndicator = true,
    Duration fadeInDuration = const Duration(milliseconds: 300),
  }) {
    // Handle null or empty URLs
    if (imageUrl == null || imageUrl.isEmpty) {
      return _defaultErrorWidget(width: width, height: height);
    }

    // Validate URL format
    if (!_isValidImageUrl(imageUrl)) {
      debugPrint('⚠️ Invalid image URL format: $imageUrl');
      return _defaultErrorWidget(width: width, height: height);
    }

    return Container(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        fadeInDuration: fadeInDuration,
        placeholder: placeholder != null
            ? (context, url) => placeholder
            : (showLoadingIndicator
                ? (context, url) => _defaultPlaceholder()
                : null),
        errorWidget: (context, url, error) {
          debugPrint('🔥 Image loading error for $url: $error');
          return errorWidget ??
              _defaultErrorWidget(width: width, height: height);
        },
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: fit,
              ),
            ),
          );
        },
        // ✅ Memory optimization settings
        memCacheHeight: height?.toInt(),
        memCacheWidth: width?.toInt(),
        maxHeightDiskCache: 500,
        maxWidthDiskCache: 500,
      ),
    );
  }

  /// ✅ Safe avatar image with circular clipping and fallback
  static Widget safeAvatarImage(
    String? imageUrl, {
    double radius = 25.0,
    Widget? fallbackChild,
    Color? backgroundColor,
  }) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? Colors.grey[200],
      child: imageUrl != null &&
              imageUrl.isNotEmpty &&
              _isValidImageUrl(imageUrl)
          ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: radius * 2,
                height: radius * 2,
                placeholder: (context, url) => _avatarPlaceholder(radius),
                errorWidget: (context, url, error) {
                  debugPrint('🔥 Avatar image loading error for $url: $error');
                  return fallbackChild ?? _avatarPlaceholder(radius);
                },
                // ✅ Memory optimization for avatars
                memCacheHeight: (radius * 2).toInt(),
                memCacheWidth: (radius * 2).toInt(),
                maxHeightDiskCache: 200,
                maxWidthDiskCache: 200,
              ),
            )
          : fallbackChild ?? _avatarPlaceholder(radius),
    );
  }

  /// ✅ Safe thumbnail image with optimized loading
  static Widget safeThumbnailImage(
    String? imageUrl, {
    double width = 80.0,
    double height = 80.0,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
  }) {
    Widget imageWidget = safeNetworkImage(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      showLoadingIndicator: false,
      placeholder: _thumbnailPlaceholder(width, height),
    );

    if (borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius,
        child: imageWidget,
      );
    }

    return Container(
      width: width,
      height: height,
      child: imageWidget,
    );
  }

  /// ✅ Safe full-screen image with zoom capabilities
  static Widget safeFullScreenImage(
    String? imageUrl, {
    BoxFit fit = BoxFit.contain,
    bool enableZoom = true,
  }) {
    if (imageUrl == null || imageUrl.isEmpty || !_isValidImageUrl(imageUrl)) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.broken_image, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Image not available', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      placeholder: (context, url) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading image...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
      errorWidget: (context, url, error) {
        debugPrint('🔥 Full-screen image loading error for $url: $error');
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text('Failed to load image', style: TextStyle(color: Colors.red)),
              SizedBox(height: 8),
              Text('Tap to retry',
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        );
      },
      // ✅ No memory cache limits for full-screen images to preserve quality
    );

    if (enableZoom) {
      imageWidget = InteractiveViewer(
        minScale: 0.5,
        maxScale: 3.0,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  /// ✅ Validate image URL format
  static bool _isValidImageUrl(String url) {
    try {
      final uri = Uri.parse(url);
      if (!uri.hasScheme ||
          (!uri.scheme.startsWith('http') && !uri.scheme.startsWith('https'))) {
        return false;
      }

      // Check for common image extensions
      final path = uri.path.toLowerCase();
      final imageExtensions = [
        '.jpg',
        '.jpeg',
        '.png',
        '.gif',
        '.webp',
        '.bmp'
      ];

      // If no extension, assume it's valid (could be a dynamic image URL)
      if (!imageExtensions.any((ext) => path.endsWith(ext))) {
        // Check if it contains common image service patterns
        if (!url.contains('firebase') &&
            !url.contains('cloudinary') &&
            !url.contains('imgur') &&
            !url.contains('amazonaws')) {
          debugPrint('⚠️ URL might not be an image: $url');
        }
      }

      return true;
    } catch (e) {
      debugPrint('⚠️ Invalid URL format: $url - $e');
      return false;
    }
  }

  /// Default placeholder widget
  static Widget _defaultPlaceholder() {
    return Container(
      color: Colors.grey[100],
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]!),
          ),
        ),
      ),
    );
  }

  /// Default error widget
  static Widget _defaultErrorWidget({double? width, double? height}) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[100],
      child: Center(
        child: Icon(
          Icons.broken_image,
          color: Colors.grey[400],
          size: (width != null && height != null)
              ? (width < height ? width : height) * 0.3
              : 32,
        ),
      ),
    );
  }

  /// Avatar placeholder
  static Widget _avatarPlaceholder(double radius) {
    return Icon(
      Icons.person,
      size: radius,
      color: Colors.grey[400],
    );
  }

  /// Thumbnail placeholder
  static Widget _thumbnailPlaceholder(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[100],
      child: Center(
        child: Icon(
          Icons.image,
          color: Colors.grey[300],
          size: (width < height ? width : height) * 0.4,
        ),
      ),
    );
  }
}

/// ✅ Extension for easy use with existing Image.network calls
extension SafeImageExtension on Image {
  static Widget safePlaceholder({double? width, double? height}) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[50],
      child: Center(
        child: Icon(Icons.image, color: Colors.grey[300]),
      ),
    );
  }
}

/// ✅ Custom error widget for image loading failures
class ImageErrorWidget extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onRetry;
  final double? width;
  final double? height;

  const ImageErrorWidget({
    Key? key,
    this.errorMessage,
    this.onRetry,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.broken_image, color: Colors.grey[400], size: 32),
          if (errorMessage != null) ...[
            SizedBox(height: 8),
            Text(
              errorMessage!,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
          if (onRetry != null) ...[
            SizedBox(height: 8),
            TextButton(
              onPressed: onRetry,
              child: Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
