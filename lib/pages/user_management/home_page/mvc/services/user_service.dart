import '/backend/backend.dart';
import '/auth/firebase_auth/auth_util.dart';

/// Service class for handling user-related operations
class UserService {
  /// Get current user document
  static Future<UsersRecord?> getCurrentUser() async {
    try {
      final query = await queryUsersRecordOnce(
        queryBuilder: (usersRecord) => usersRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
        singleRecord: true,
      );
      return query.isNotEmpty ? query.first : null;
    } catch (e) {
      print('Error fetching current user: $e');
      return null;
    }
  }

  /// Check if user has location enabled
  static bool hasLocationEnabled(UsersRecord? user) {
    return user?.location != null;
  }

  /// Get user's display city
  static String getUserDisplayLocation(UsersRecord? user) {
    if (user?.city != null && user!.city!.isNotEmpty) {
      return user.city!;
    }
    return 'Location Not Set';
  }

  /// Update user's location preferences
  static Future<bool> updateUserLocation(
      UsersRecord user, LatLng location, String? city) async {
    try {
      await user.reference.update(createUsersRecordData(
        location: location,
        city: city,
      ));
      return true;
    } catch (e) {
      print('Error updating user location: $e');
      return false;
    }
  }
}
