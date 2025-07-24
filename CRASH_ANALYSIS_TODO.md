# Our Garden App Crash Analysis & To-Do List

## Critical Issues

### 1. Firestore Security Rules Issues

- **Symptoms**: Permission denied errors when accessing user data
- **Log Evidence**: `W/Firestore: Listen for Query(target=Query(users where uid==qVaVKihC8pOCl5zKTXhrsPnGgUI2 order by __name__);limitType=LIMIT_TO_FIRST) failed: Status{code=PERMISSION_DENIED, description=Missing or insufficient permissions., cause=null}`
- **Action Items**:
  - [ ] Update Firestore security rules to allow authenticated users to read their own data
  - [ ] Example rule: `allow read: if request.auth != null && request.auth.uid == userId;`
  - [ ] Add graceful error handling for Firestore permission errors throughout the app

### 2. Graphics Buffer Allocation Errors

- **Symptoms**: Failed buffer allocations for rendering images
- **Log Evidence**: `E/GraphicBufferAllocator: Failed to allocate (4 x 4) layerCount 1 format 56 usage b00: 1`
- **Action Items**:
  - [x] Implement memory-efficient image loading with proper error handling (NetworkAwareImage)
  - [x] Add placeholder images for loading failures (NetworkAwareImage)
  - [ ] Consider using smaller image resolutions or compression

### 3. Signal Catcher Thread Issue

- **Symptoms**: App wrote stack traces to tombstoned, indicating a crash
- **Log Evidence**: `I/om.plantculture: Thread[2,tid=8779,WaitingInMainSignalCatcherLoop,Thread*=0xb400006dfebc1f00,peer=0x42c0300,"Signal Catcher"]: reacting to signal 3`
- **Action Items**:
  - [ ] Check for native code crashes or memory issues
  - [ ] Consider reducing memory usage in the app
  - [x] Implement better error boundaries in Flutter widgets (global error boundary in main.dart)

## Other Issues to Fix

### 4. Firebase App Check Missing

- **Symptoms**: Warnings about App Check provider missing
- **Log Evidence**: `W/LocalRequestInterceptor: Error getting App Check token; using placeholder token instead. Error: com.google.firebase.FirebaseException: No AppCheckProvider installed.`
- **Action Items**:
  - [ ] Configure Firebase App Check to secure backend resources
  - [ ] Add proper App Check initialization in the app

### 5. Cloud Function Not Found Error

- **Symptoms**: Cloud function call failing with NOT_FOUND
- **Log Evidence**: `I/flutter: Cloud call error! ffPrivateApiCallCode: not-found Details: null Message: NOT_FOUND`
- **Action Items**:
  - [ ] Check Firebase Cloud Functions setup
  - [ ] Ensure all cloud functions are properly deployed
  - [ ] Add better error handling for cloud function calls

### 6. Network Image Loading Issues

- **Symptoms**: Possible invalid image URLs causing errors
- **Log Evidence**: `Invalid argument(s): No host specified in URI file:///`
- **Action Items**:
  - [x] Add validation for all image URLs before loading (NetworkAwareImage)
  - [x] Implement fallback images for null or invalid URLs (NetworkAwareImage)
  - [x] Consider adding a custom image loading widget with error handling (NetworkAwareImage)

### 7. Layout Overflow Issues

- **Symptoms**: Widgets overflowing their containers
- **Log Evidence**: `A RenderFlex overflowed by 47 pixels on the bottom.`
- **Action Items**:
  - [x] Fix layout in user_profile_widget.dart around line 165
  - [x] Use SingleChildScrollView for scrollable content
  - [x] Consider using more Expanded or Flexible widgets to prevent overflow

### 8. Memory Optimization

- **Action Items**:
  - [ ] Implement image caching strategies with size limits
  - [ ] Dispose of large objects when not needed
  - [ ] Add memory profiling to detect memory leaks
  - [ ] Consider using the `flutter_memory_manager` package

### 9. Google API Issues

- **Symptoms**: Google API failures with security exceptions
- **Log Evidence**: `E/GoogleApiManager: Failed to get service from broker. java.lang.SecurityException: Unknown calling package name 'com.google.android.gms'.`
- **Action Items**:
  - [ ] Check Google Play Services configuration
  - [ ] Ensure proper API keys and permissions
  - [ ] Add fallbacks for Google services not being available

## Overall Stability Improvements

### 10. Error Boundaries

- **Action Items**:
  - [x] Implement error boundary widgets around critical UI components (global error boundary in main.dart)
  - [ ] Create a centralized error reporting system
  - [ ] Add try/catch blocks around all async operations (in progress)

### 11. Null Safety

- **Action Items**:
  - [ ] Review all usage of null assertions (!) and replace with safe null handling (in progress)
  - [ ] Use null-aware operators (?., ??, ?=) consistently (in progress)
  - [ ] Add null checks before accessing properties of potentially null objects (in progress)

### 12. Graceful Degradation

- **Action Items**:
  - [ ] Implement offline mode functionality
  - [ ] Create fallback UI states for all error conditions
  - [ ] Ensure app remains usable even when certain features fail

### 13. Testing Strategy

- **Action Items**:
  - [ ] Add widget tests for UI components
  - [ ] Implement integration tests for critical user flows
  - [ ] Create unit tests for business logic
  - [ ] Set up automated crash reporting (Firebase Crashlytics)

## Next Steps

1. Address the Firestore security rules issue first, as this is blocking normal app functionality
2. Fix the memory/graphics buffer allocation errors to prevent crashes
3. Implement better error handling throughout the app
4. Set up proper error monitoring and crash reporting
5. Address layout issues and other UI problems

## Progress Notes

- [x] Global error boundary added in main.dart
- [x] Safe image loading implemented with NetworkAwareImage and used in user_profile_widget.dart
- [x] Layout overflow in user_profile_widget.dart fixed
- [ ] Async error handling and null safety audits are in progress across all major screens (marketplace, chat, garden, etc.)
