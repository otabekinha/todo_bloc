// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'todo_model.g.dart';
  
@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final DateTime createdAt;

  Todo({required this.title, required this.createdAt});

  Todo copyWith({
    String? title,
    DateTime? createdAt,
  }) {
    return Todo(
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() => 'Todo(title: $title, createdAt: $createdAt)';
}
