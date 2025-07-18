import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import '../models/user_model.dart';
import '../../core/services/auth_service.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  // Get current user data
  Future<UserModel?> getCurrentUser() async {
    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null) return null;

      final doc =
          await _firestore.collection('users').doc(currentUser.uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromJson({...data, 'id': doc.id});
      }
      return null;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  // Get user by ID
  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromJson({...data, 'id': doc.id});
      }
      return null;
    } catch (e) {
      print('Error getting user by ID: $e');
      return null;
    }
  }

  // Create a new user
  Future<String?> createUser(UserModel user) async {
    try {
      final docRef =
          await _firestore.collection('users').doc(user.uid).set(user.toJson());
      return user.uid;
    } catch (e) {
      print('Error creating user: $e');
      return null;
    }
  }

  // Update user data
  Future<bool> updateUser(String userId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('users').doc(userId).update(updates);
      return true;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }

  // Update user location
  Future<bool> updateUserLocation(
      String userId, Map<String, double> location) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'location': location,
      });
      return true;
    } catch (e) {
      print('Error updating user location: $e');
      return false;
    }
  }

  // Mark first sign in as complete
  Future<bool> markFirstSignInComplete() async {
    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null) return false;

      await _firestore.collection('users').doc(currentUser.uid).update({
        'isFirstSignIn': false,
      });
      return true;
    } catch (e) {
      print('Error marking first sign in complete: $e');
      return false;
    }
  }

  // Update last task reset date
  Future<bool> updateLastTaskResetDate(DateTime date) async {
    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null) return false;

      await _firestore.collection('users').doc(currentUser.uid).update({
        'lastTaskResetDate': date.toIso8601String(),
      });
      return true;
    } catch (e) {
      print('Error updating last task reset date: $e');
      return false;
    }
  }

  // Update user profile
  Future<bool> updateUserProfile({
    required String displayName,
    String? photoUrl,
    String? bio,
    String? phoneNumber,
  }) async {
    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null) return false;

      final updates = <String, dynamic>{
        'displayName': displayName,
      };

      if (photoUrl != null) updates['photoUrl'] = photoUrl;
      if (bio != null) updates['bio'] = bio;
      if (phoneNumber != null) updates['phoneNumber'] = phoneNumber;

      await _firestore.collection('users').doc(currentUser.uid).update(updates);
      return true;
    } catch (e) {
      print('Error updating user profile: $e');
      return false;
    }
  }

  // Get users by location (for nearby users)
  Future<List<UserModel>> getUsersByLocation({
    required double latitude,
    required double longitude,
    required double radius,
  }) async {
    try {
      // For now, get all users and filter by distance
      // In production, use Firestore GeoPoint queries
      final snapshot = await _firestore.collection('users').get();

      final allUsers = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromJson({...data, 'id': doc.id});
      }).toList();

      // Filter by distance
      return allUsers.where((user) {
        if (user.location == null) return false;

        final userLat = user.location!['latitude']!;
        final userLng = user.location!['longitude']!;

        final distance =
            _calculateDistance(latitude, longitude, userLat, userLng);

        return distance <= radius;
      }).toList();
    } catch (e) {
      print('Error getting users by location: $e');
      return [];
    }
  }

  // Search users by name
  Future<List<UserModel>> searchUsersByName(String searchTerm) async {
    try {
      // Note: This is a simple implementation
      // In production, you'd use Firestore's full-text search or Algolia
      final snapshot = await _firestore.collection('users').get();

      final allUsers = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return UserModel.fromJson({...data, 'id': doc.id});
      }).toList();

      return allUsers.where((user) {
        return user.displayName
            .toLowerCase()
            .contains(searchTerm.toLowerCase());
      }).toList();
    } catch (e) {
      print('Error searching users by name: $e');
      return [];
    }
  }

  // Delete user account
  Future<bool> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      return true;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }

  // Get user statistics
  Future<Map<String, dynamic>> getUserStats(String userId) async {
    try {
      // Get user's gardens count
      final gardensSnapshot = await _firestore
          .collection('gardens')
          .where('userId', isEqualTo: userId)
          .where('isActive', isEqualTo: true)
          .get();

      // Get user's completed tasks count
      final gardenTasksSnapshot = await _firestore
          .collection('gardenTasks')
          .where('userId', isEqualTo: userId)
          .where('isCompleted', isEqualTo: true)
          .get();

      final plantTasksSnapshot = await _firestore
          .collection('plantTasks')
          .where('userId', isEqualTo: userId)
          .where('isCompleted', isEqualTo: true)
          .get();

      // Get user's products count
      final productsSnapshot = await _firestore
          .collection('products')
          .where('sellerId', isEqualTo: userId)
          .where('isArchived', isEqualTo: false)
          .get();

      return {
        'gardensCount': gardensSnapshot.docs.length,
        'completedTasksCount':
            gardenTasksSnapshot.docs.length + plantTasksSnapshot.docs.length,
        'productsCount': productsSnapshot.docs.length,
      };
    } catch (e) {
      print('Error getting user stats: $e');
      return {
        'gardensCount': 0,
        'completedTasksCount': 0,
        'productsCount': 0,
      };
    }
  }

  // Calculate distance between two points using Haversine formula
  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371000; // Earth's radius in meters
    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);
    final double a = math.pow(math.sin(dLat / 2), 2) +
        math.cos(_degreesToRadians(lat1)) *
            math.cos(_degreesToRadians(lat2)) *
            math.pow(math.sin(dLon / 2), 2);
    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180);
  }
}
