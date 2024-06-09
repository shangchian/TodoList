// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      dueDate: DateTime.parse(json['dueDate'] as String),
      priority: json['priority'] as String? ?? 'medium',
      category: json['category'] as String? ?? 'General',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'dueDate': instance.dueDate.toIso8601String(),
      'priority': instance.priority,
      'category': instance.category,
      'isCompleted': instance.isCompleted,
    };
