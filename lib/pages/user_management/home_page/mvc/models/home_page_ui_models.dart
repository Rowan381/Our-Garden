import 'package:flutter/material.dart';

/// Simple coordinate model
class Coordinates {
  final double latitude;
  final double longitude;

  const Coordinates(this.latitude, this.longitude);
}

/// Model representing user location data
class UserLocationModel {
  final String? city;
  final String? state;
  final String? country;
  final Coordinates? coordinates;

  const UserLocationModel({
    this.city,
    this.state,
    this.country,
    this.coordinates,
  });

  bool get hasLocation => coordinates != null;

  String get displayLocation {
    if (city != null) return city!;
    if (state != null) return state!;
    if (country != null) return country!;
    return 'Location Not Set';
  }
}

/// Model for task items displayed in the UI
class TaskItemModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime? dueDate;
  final String type; // 'garden' or 'plant'

  const TaskItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.dueDate,
    required this.type,
  });

  TaskItemModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
    String? type,
  }) {
    return TaskItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      type: type ?? this.type,
    );
  }
}

/// Model for marketplace product items
class ProductItemModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String sellerId;
  final String sellerName;
  final double distance;

  const ProductItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.sellerId,
    required this.sellerName,
    required this.distance,
  });
}

/// Model for navigation menu items
class NavigationItemModel {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;

  const NavigationItemModel({
    required this.title,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
  });
}
