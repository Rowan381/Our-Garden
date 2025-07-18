class TaskModel {
  final String id;
  final String title;
  final String description;
  final String type; // 'garden' or 'plant'
  final String gardenId;
  final String? plantId;
  final DateTime dueDate;
  final bool isCompleted;
  final bool completedToday;
  final DateTime createdAt;
  final String priority; // 'low', 'medium', 'high'
  final String category; // 'watering', 'fertilizing', 'pruning', etc.

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.gardenId,
    this.plantId,
    required this.dueDate,
    this.isCompleted = false,
    this.completedToday = false,
    required this.createdAt,
    this.priority = 'medium',
    required this.category,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      gardenId: json['gardenId'] ?? '',
      plantId: json['plantId'],
      dueDate: DateTime.parse(json['dueDate'] ?? DateTime.now().toIso8601String()),
      isCompleted: json['isCompleted'] ?? false,
      completedToday: json['completedToday'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      priority: json['priority'] ?? 'medium',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'gardenId': gardenId,
      'plantId': plantId,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted,
      'completedToday': completedToday,
      'createdAt': createdAt.toIso8601String(),
      'priority': priority,
      'category': category,
    };
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? type,
    String? gardenId,
    String? plantId,
    DateTime? dueDate,
    bool? isCompleted,
    bool? completedToday,
    DateTime? createdAt,
    String? priority,
    String? category,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      gardenId: gardenId ?? this.gardenId,
      plantId: plantId ?? this.plantId,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      completedToday: completedToday ?? this.completedToday,
      createdAt: createdAt ?? this.createdAt,
      priority: priority ?? this.priority,
      category: category ?? this.category,
    );
  }

  bool get isOverdue => dueDate.isBefore(DateTime.now()) && !isCompleted;
  bool get isDueToday => dueDate.day == DateTime.now().day && 
                        dueDate.month == DateTime.now().month && 
                        dueDate.year == DateTime.now().year;

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, type: $type, completed: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TaskModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
} 