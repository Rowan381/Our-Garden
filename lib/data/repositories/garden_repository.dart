import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/garden_model.dart';
import '../../core/services/auth_service.dart';

class GardenRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  // Get gardens for current user
  Future<List<GardenModel>> getUserGardens() async {
    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null) return [];

      final snapshot = await _firestore.collection('gardens')
          .where('userId', isEqualTo: currentUser.uid)
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return GardenModel.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      print('Error getting user gardens: $e');
      return [];
    }
  }

  // Get garden by ID
  Future<GardenModel?> getGardenById(String gardenId) async {
    try {
      final doc = await _firestore.collection('gardens').doc(gardenId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return GardenModel.fromJson({...data, 'id': doc.id});
      }
      return null;
    } catch (e) {
      print('Error getting garden by ID: $e');
      return null;
    }
  }

  // Create a new garden
  Future<String?> createGarden(GardenModel garden) async {
    try {
      final docRef = await _firestore.collection('gardens').add(garden.toJson());
      return docRef.id;
    } catch (e) {
      print('Error creating garden: $e');
      return null;
    }
  }

  // Update a garden
  Future<bool> updateGarden(String gardenId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('gardens').doc(gardenId).update(updates);
      return true;
    } catch (e) {
      print('Error updating garden: $e');
      return false;
    }
  }

  // Delete a garden (soft delete)
  Future<bool> deleteGarden(String gardenId) async {
    try {
      await _firestore.collection('gardens').doc(gardenId).update({
        'isActive': false,
      });
      return true;
    } catch (e) {
      print('Error deleting garden: $e');
      return false;
    }
  }

  // Update last watered date
  Future<bool> updateLastWatered(String gardenId) async {
    try {
      await _firestore.collection('gardens').doc(gardenId).update({
        'lastWatered': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print('Error updating last watered: $e');
      return false;
    }
  }

  // Get gardens by location (for nearby gardens)
  Future<List<GardenModel>> getGardensByLocation({
    required double latitude,
    required double longitude,
    required double radius,
  }) async {
    try {
      // For now, get all gardens and filter by distance
      // In production, use Firestore GeoPoint queries
      final snapshot = await _firestore.collection('gardens')
          .where('isActive', isEqualTo: true)
          .get();

      final allGardens = snapshot.docs.map((doc) {
        final data = doc.data();
        return GardenModel.fromJson({...data, 'id': doc.id});
      }).toList();

      // Filter by distance
      return allGardens.where((garden) {
        if (garden.location == null) return false;
        
        final gardenLat = garden.location!['latitude']!;
        final gardenLng = garden.location!['longitude']!;
        
        final distance = _calculateDistance(
          latitude, longitude, gardenLat, gardenLng);
        
        return distance <= radius;
      }).toList();
    } catch (e) {
      print('Error getting gardens by location: $e');
      return [];
    }
  }

  // Calculate distance between two points using Haversine formula
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371000; // Earth's radius in meters
    
    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);
    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) *
        sin(dLon / 2) * sin(dLon / 2);
    
    final double c = 2 * atan(sqrt(a) / sqrt(1 - a));
    
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (3.14159265359 / 180);
  }
} 