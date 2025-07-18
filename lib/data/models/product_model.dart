class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String sellerId;
  final String sellerName;
  final String? imageUrl;
  final bool isArchived;
  final DateTime createdAt;
  final Map<String, double>? location;
  final String category;
  final int quantity;
  final String unit;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.sellerId,
    required this.sellerName,
    this.imageUrl,
    this.isArchived = false,
    required this.createdAt,
    this.location,
    required this.category,
    required this.quantity,
    required this.unit,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      sellerId: json['sellerId'] ?? '',
      sellerName: json['sellerName'] ?? '',
      imageUrl: json['imageUrl'],
      isArchived: json['isArchived'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      location: json['location'] != null 
          ? Map<String, double>.from(json['location'])
          : null,
      category: json['category'] ?? '',
      quantity: json['quantity'] ?? 0,
      unit: json['unit'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'imageUrl': imageUrl,
      'isArchived': isArchived,
      'createdAt': createdAt.toIso8601String(),
      'location': location,
      'category': category,
      'quantity': quantity,
      'unit': unit,
    };
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? sellerId,
    String? sellerName,
    String? imageUrl,
    bool? isArchived,
    DateTime? createdAt,
    Map<String, double>? location,
    String? category,
    int? quantity,
    String? unit,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      imageUrl: imageUrl ?? this.imageUrl,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      location: location ?? this.location,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, price: $price, seller: $sellerName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 