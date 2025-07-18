class UserModel {
  final String id;
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final Map<String, double>? location;
  final bool isFirstSignIn;
  final DateTime? lastTaskResetDate;
  final DateTime createdAt;
  final String? phoneNumber;
  final String? bio;
  final bool isVerified;
  final String? stripeAccountId;

  UserModel({
    required this.id,
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.location,
    this.isFirstSignIn = true,
    this.lastTaskResetDate,
    required this.createdAt,
    this.phoneNumber,
    this.bio,
    this.isVerified = false,
    this.stripeAccountId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      displayName: json['displayName'] ?? '',
      photoUrl: json['photoUrl'],
      location: json['location'] != null 
          ? Map<String, double>.from(json['location'])
          : null,
      isFirstSignIn: json['isFirstSignIn'] ?? true,
      lastTaskResetDate: json['lastTaskResetDate'] != null 
          ? DateTime.parse(json['lastTaskResetDate'])
          : null,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      phoneNumber: json['phoneNumber'],
      bio: json['bio'],
      isVerified: json['isVerified'] ?? false,
      stripeAccountId: json['stripeAccountId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'location': location,
      'isFirstSignIn': isFirstSignIn,
      'lastTaskResetDate': lastTaskResetDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'phoneNumber': phoneNumber,
      'bio': bio,
      'isVerified': isVerified,
      'stripeAccountId': stripeAccountId,
    };
  }

  UserModel copyWith({
    String? id,
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    Map<String, double>? location,
    bool? isFirstSignIn,
    DateTime? lastTaskResetDate,
    DateTime? createdAt,
    String? phoneNumber,
    String? bio,
    bool? isVerified,
    String? stripeAccountId,
  }) {
    return UserModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      location: location ?? this.location,
      isFirstSignIn: isFirstSignIn ?? this.isFirstSignIn,
      lastTaskResetDate: lastTaskResetDate ?? this.lastTaskResetDate,
      createdAt: createdAt ?? this.createdAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      isVerified: isVerified ?? this.isVerified,
      stripeAccountId: stripeAccountId ?? this.stripeAccountId,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, displayName: $displayName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 