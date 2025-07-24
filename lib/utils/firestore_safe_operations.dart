/// Safe Firestore operations with proper error handling
/// This utility helps prevent crashes from permission denied errors
/// and provides fallback mechanisms for common Firestore operations.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirestoreSafeOperations {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// ✅ Safe user document fetch with permission error handling
  static Future<DocumentSnapshot?> safeGetUserDocument(String userId) async {
    try {
      // Ensure user is authenticated
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        debugPrint('🔐 User not authenticated - cannot fetch user document');
        return null;
      }

      // Only allow fetching current user's document
      if (currentUser.uid != userId) {
        debugPrint(
            '🔐 Permission denied - cannot fetch other user\'s document');
        return null;
      }

      final doc = await _firestore.collection('users').doc(userId).get();

      if (doc.exists) {
        debugPrint('✅ Successfully fetched user document for $userId');
        return doc;
      } else {
        debugPrint('⚠️ User document does not exist for $userId');
        return null;
      }
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        debugPrint(
            '🔒 Permission denied accessing user document: ${e.message}');
        debugPrint('💡 Check Firestore security rules for users collection');
      } else {
        debugPrint(
            '🔥 Firebase error fetching user document: ${e.code} - ${e.message}');
      }
      return null;
    } catch (e) {
      debugPrint('🔥 Unexpected error fetching user document: $e');
      return null;
    }
  }

  /// ✅ Safe user document update with permission error handling
  static Future<bool> safeUpdateUserDocument(
      String userId, Map<String, dynamic> data) async {
    try {
      // Ensure user is authenticated
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        debugPrint('🔐 User not authenticated - cannot update user document');
        return false;
      }

      // Only allow updating current user's document
      if (currentUser.uid != userId) {
        debugPrint(
            '🔐 Permission denied - cannot update other user\'s document');
        return false;
      }

      await _firestore.collection('users').doc(userId).update(data);
      debugPrint('✅ Successfully updated user document for $userId');
      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        debugPrint('🔒 Permission denied updating user document: ${e.message}');
        debugPrint('💡 Check Firestore security rules for users collection');
      } else {
        debugPrint(
            '🔥 Firebase error updating user document: ${e.code} - ${e.message}');
      }
      return false;
    } catch (e) {
      debugPrint('🔥 Unexpected error updating user document: $e');
      return false;
    }
  }

  /// ✅ Safe user document creation with permission error handling
  static Future<bool> safeCreateUserDocument(
      String userId, Map<String, dynamic> data) async {
    try {
      // Ensure user is authenticated
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        debugPrint('🔐 User not authenticated - cannot create user document');
        return false;
      }

      // Only allow creating current user's document
      if (currentUser.uid != userId) {
        debugPrint(
            '🔐 Permission denied - cannot create other user\'s document');
        return false;
      }

      await _firestore.collection('users').doc(userId).set(data);
      debugPrint('✅ Successfully created user document for $userId');
      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        debugPrint('🔒 Permission denied creating user document: ${e.message}');
        debugPrint('💡 Check Firestore security rules for users collection');
      } else {
        debugPrint(
            '🔥 Firebase error creating user document: ${e.code} - ${e.message}');
      }
      return false;
    } catch (e) {
      debugPrint('🔥 Unexpected error creating user document: $e');
      return false;
    }
  }

  /// ✅ Safe user document stream with permission error handling
  static Stream<DocumentSnapshot?> safeUserDocumentStream(String userId) {
    try {
      // Ensure user is authenticated
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        debugPrint('🔐 User not authenticated - returning empty stream');
        return Stream.value(null);
      }

      // Only allow streaming current user's document
      if (currentUser.uid != userId) {
        debugPrint(
            '🔐 Permission denied - cannot stream other user\'s document');
        return Stream.value(null);
      }

      return _firestore.collection('users').doc(userId).snapshots().map((doc) {
        if (doc.exists) {
          debugPrint('✅ User document stream update for $userId');
          return doc;
        } else {
          debugPrint('⚠️ User document does not exist in stream for $userId');
          return null;
        }
      }).handleError((error) {
        if (error is FirebaseException && error.code == 'permission-denied') {
          debugPrint(
              '🔒 Permission denied in user document stream: ${error.message}');
          debugPrint('💡 Check Firestore security rules for users collection');
        } else {
          debugPrint('🔥 Error in user document stream: $error');
        }
        return null;
      });
    } catch (e) {
      debugPrint('🔥 Unexpected error setting up user document stream: $e');
      return Stream.value(null);
    }
  }

  /// ✅ Generic safe collection query with permission error handling
  static Stream<QuerySnapshot?> safeCollectionStream(
    String collectionPath, {
    String? whereField,
    dynamic isEqualTo,
    int? limit,
  }) {
    try {
      // Ensure user is authenticated for any collection access
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        debugPrint(
            '🔐 User not authenticated - returning empty collection stream');
        return Stream.value(null);
      }

      Query query = _firestore.collection(collectionPath);

      if (whereField != null && isEqualTo != null) {
        query = query.where(whereField, isEqualTo: isEqualTo);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      return query.snapshots().map((snapshot) {
        debugPrint(
            '✅ Collection stream update for $collectionPath (${snapshot.docs.length} docs)');
        return snapshot;
      }).handleError((error) {
        if (error is FirebaseException && error.code == 'permission-denied') {
          debugPrint(
              '🔒 Permission denied in collection stream ($collectionPath): ${error.message}');
          debugPrint(
              '💡 Check Firestore security rules for $collectionPath collection');
        } else {
          debugPrint('🔥 Error in collection stream ($collectionPath): $error');
        }
        return null;
      });
    } catch (e) {
      debugPrint(
          '🔥 Unexpected error setting up collection stream for $collectionPath: $e');
      return Stream.value(null);
    }
  }

  /// ✅ Check if current user has permission to access a document
  static bool canAccessUserDocument(String userId) {
    final currentUser = _auth.currentUser;
    return currentUser != null && currentUser.uid == userId;
  }

  /// ✅ Get current authenticated user ID safely
  static String? getCurrentUserId() {
    final currentUser = _auth.currentUser;
    return currentUser?.uid;
  }

  /// ✅ Check if user is authenticated
  static bool isUserAuthenticated() {
    return _auth.currentUser != null;
  }
}
