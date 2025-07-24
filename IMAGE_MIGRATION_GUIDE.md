/// Example migration guide showing how to replace unsafe image loading
/// with the SafeImageLoader utilities to prevent graphics buffer crashes.

/\*
===== BEFORE (Unsafe image loading that can cause crashes) =====

child: Image.network(
'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/qiGqyt5ktHa4wEBF2FEm/assets/m8y3kksvax1i/noProfile.webp',
fit: BoxFit.cover,
errorBuilder: (context, error, stackTrace) => Image.asset(
'assets/images/error_image.webp',
fit: BoxFit.cover,
),
),

===== AFTER (Safe image loading with comprehensive error handling) =====

SafeImageLoader.safeAvatarImage(
'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/qiGqyt5ktHa4wEBF2FEm/assets/m8y3kksvax1i/noProfile.webp',
radius: 32.5, // half of 65.0
backgroundColor: Colors.grey[200],
fallbackChild: Icon(Icons.person, size: 32, color: Colors.grey[400]),
)

===============================================

===== For general network images =====

BEFORE:
CachedNetworkImage(
imageUrl: imageUrl,
fit: BoxFit.cover,
placeholder: (context, url) => CircularProgressIndicator(),
errorWidget: (context, url, error) => Icon(Icons.error),
)

AFTER:
SafeImageLoader.safeNetworkImage(
imageUrl,
width: desiredWidth,
height: desiredHeight,
fit: BoxFit.cover,
showLoadingIndicator: true,
)

===============================================

===== For thumbnail images =====

BEFORE:
Image.network(
thumbnailUrl,
width: 80,
height: 80,
fit: BoxFit.cover,
)

AFTER:
SafeImageLoader.safeThumbnailImage(
thumbnailUrl,
width: 80,
height: 80,
fit: BoxFit.cover,
borderRadius: BorderRadius.circular(8), // optional
)

===============================================

===== Key Benefits of SafeImageLoader =====

1. ✅ Prevents graphics buffer allocation errors
2. ✅ Validates image URLs before loading
3. ✅ Provides consistent fallback behavior
4. ✅ Optimizes memory usage with cache limits
5. ✅ Handles network errors gracefully
6. ✅ Provides loading states and error feedback
7. ✅ Supports different image types (avatar, thumbnail, full-screen)
8. ✅ Comprehensive error logging for debugging

===============================================

===== Migration Steps =====

1. Import the SafeImageLoader utility:
   import 'package:your_app/utils/safe_image_loader.dart';

2. Replace Image.network calls with SafeImageLoader.safeNetworkImage
3. Replace CachedNetworkImage with SafeImageLoader methods
4. For circular images/avatars, use SafeImageLoader.safeAvatarImage
5. For small images/thumbnails, use SafeImageLoader.safeThumbnailImage
6. For full-screen images, use SafeImageLoader.safeFullScreenImage

7. Test the app and monitor logs for any image loading issues
8. Remove old error handling code as it's now built into SafeImageLoader

\*/
