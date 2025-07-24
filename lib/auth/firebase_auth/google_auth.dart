import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

Future<UserCredential?> googleSignInFunc() async {
  try {
    // Web implementation
    if (kIsWeb) {
      return await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
    }

    // For non-web platforms, use Firebase's built-in Google provider
    // This approach bypasses the direct use of google_sign_in package
    final googleProvider = GoogleAuthProvider();

    // Add scopes (optional)
    googleProvider.addScope('email');
    googleProvider.addScope('profile');

    // Sign in with Firebase Auth directly
    return await FirebaseAuth.instance.signInWithProvider(googleProvider);
  } catch (e) {
    print('Google Sign-In failed: $e');
    return null;
  }
}

Future<void> signOutWithGoogle() async {
  await FirebaseAuth.instance.signOut();
}
