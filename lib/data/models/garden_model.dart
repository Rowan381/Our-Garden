class GardenModel {
  final String id;
  final String name;
  final String description;
  final String userId;
  final String? imageUrl;
  final Map<String, double>? location;
  final DateTime createdAt;
  final DateTime? lastWatered;
  final bool isActive;
  final String size;
  final String type;

  GardenModel({
    required this.id,
    required this.name,
    required this.description,
    required this.userId,
    this.imageUrl,
    this.location,
    required this.createdAt,
    this.lastWatered,
    this.isActive = true,
    required this.size,
    required this.type,
  });

  factory GardenModel.fromJson(Map<String, dynamic> json) {
    return GardenModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      userId: json['userId'] ?? '',
      imageUrl: json['imageUrl'],
      location: json['location'] != null 
          ? Map<String, double>.from(json['location'])
          : null,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastWatered: json['lastWatered'] != null 
          ? DateTime.parse(json['lastWatered'])
          : null,
      isActive: json['isActive'] ?? true,
      size: json['size'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'userId': userId,
      'imageUrl': imageUrl,
      'location': location,
      'createdAt': createdAt.toIso8601String(),
      'lastWatered': lastWatered?.toIso8601String(),
      'isActive': isActive,
      'size': size,
      'type': type,
    };
  }

  GardenModel copyWith({
    String? id,
    String? name,
    String? description,
    String? userId,
    String? imageUrl,
    Map<String, double>? location,
    DateTime? createdAt,
    DateTime? lastWatered,
    bool? isActive,
    String? size,
    String? type,
  }) {
    return GardenModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      lastWatered: lastWatered ?? this.lastWatered,
      isActive: isActive ?? this.isActive,
      size: size ?? this.size,
      type: type ?? this.type,
    );
  }

  @override
  String toString() {
    return 'GardenModel(id: $id, name: $name, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GardenModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 