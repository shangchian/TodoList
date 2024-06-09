import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority;
  final String category;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    required this.dueDate,
    this.priority = 'medium',
    this.category = 'General',
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    String? priority,
    String? category,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
