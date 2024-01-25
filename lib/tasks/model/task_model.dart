import 'package:equatable/equatable.dart';

// Class representing a task in the application
class TaskModel extends Equatable {
  // Properties of a task
  final String title;
  final String description;
  final String category;
  final bool isCompleted;

  // Constructor for creating a TaskModel instance
  const TaskModel({
    required this.title,
    required this.description,
    required this.category,
    required this.isCompleted,
  });

  // Override to define the properties considered for equality comparison
  @override
  List<Object?> get props => [title, description, category, isCompleted];

  // Factory method to create a TaskModel instance from JSON data
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }

  // Method to create a copy of the TaskModel instance with updated properties
  TaskModel copyWith({
    String? title,
    String? description,
    String? category,
    bool? isCompleted,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Method to convert the TaskModel instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'isCompleted': isCompleted,
    };
  }
}
