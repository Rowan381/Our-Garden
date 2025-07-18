import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../../core/services/auth_service.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  // Get all products (for users without location)
  Future<List<ProductModel>> getAllProducts({int? limit}) async {
    try {
      Query query = _firestore
          .collection('products')
          .where('isArchived', isEqualTo: false)
          .orderBy('createdAt', descending: true);

      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ProductModel.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      print('Error getting all products: $e');
      return [];
    }
  }

  // Get nearby products based on location
  Future<List<ProductModel>> getNearbyProducts({
    required double latitude,
    required double longitude,
    required double radius,
    int? limit,
  }) async {
    try {
      // For now, we'll get all products and filter by distance
      // In a production app, you'd use Firestore GeoPoint queries
      final allProducts = await getAllProducts();

      // Filter by distance
      final nearbyProducts = allProducts.where((product) {
        if (product.location == null) return false;

        final productLat = product.location!['latitude']!;
        final productLng = product.location!['longitude']!;

        final distance =
            _calculateDistance(latitude, longitude, productLat, productLng);

        return distance <= radius;
      }).toList();

      // Sort by distance
      nearbyProducts.sort((a, b) {
        final distanceA = _calculateDistance(latitude, longitude,
            a.location!['latitude']!, a.location!['longitude']!);
        final distanceB = _calculateDistance(latitude, longitude,
            b.location!['latitude']!, b.location!['longitude']!);
        return distanceA.compareTo(distanceB);
      });

      if (limit != null) {
        return nearbyProducts.take(limit).toList();
      }

      return nearbyProducts;
    } catch (e) {
      print('Error getting nearby products: $e');
      return [];
    }
  }

  // Get products by seller
  Future<List<ProductModel>> getProductsBySeller(String sellerId) async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('sellerId', isEqualTo: sellerId)
          .where('isArchived', isEqualTo: false)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ProductModel.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      print('Error getting products by seller: $e');
      return [];
    }
  }

  // Get pending orders for current user
  Future<List<dynamic>> getPendingOrders() async {
    try {
      final currentUser = _authService.currentUser;
      if (currentUser == null) return [];

      final snapshot = await _firestore
          .collection('orders')
          .where('buyerId', isEqualTo: currentUser.uid)
          .where('buyerPaid', isEqualTo: false)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {...data, 'id': doc.id};
      }).toList();
    } catch (e) {
      print('Error getting pending orders: $e');
      return [];
    }
  }

  // Create a new product
  Future<String?> createProduct(ProductModel product) async {
    try {
      final docRef =
          await _firestore.collection('products').add(product.toJson());
      return docRef.id;
    } catch (e) {
      print('Error creating product: $e');
      return null;
    }
  }

  // Update a product
  Future<bool> updateProduct(
      String productId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection('products').doc(productId).update(updates);
      return true;
    } catch (e) {
      print('Error updating product: $e');
      return false;
    }
  }

  // Delete a product (soft delete by archiving)
  Future<bool> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).update({
        'isArchived': true,
      });
      return true;
    } catch (e) {
      print('Error deleting product: $e');
      return false;
    }
  }

  // Get product by ID
  Future<ProductModel?> getProductById(String productId) async {
    try {
      final doc = await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return ProductModel.fromJson({...data, 'id': doc.id});
      }
      return null;
    } catch (e) {
      print('Error getting product by ID: $e');
      return null;
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
    return degrees * (3.14159265359 / 180);
  }
}
