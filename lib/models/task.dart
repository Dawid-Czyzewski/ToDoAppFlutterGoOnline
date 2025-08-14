import '../database/db_queries.dart';

class Task {
  final int? id;
  final String title;
  final String? description;
  final DateTime? deadline;
  final bool isDone;

  const Task({
    this.id,
    required this.title,
    this.description,
    this.deadline,
    this.isDone = false,
  });

  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? deadline,
    bool? isDone,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, Object?> toMap() {
    return {
      kColId: id,
      kColTitle: title,
      kColDescription: description,
      kColDeadline: deadline?.toIso8601String(),
      kColIsDone: isDone ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, Object?> map) {
    final deadlineStr = map[kColDeadline] as String?;
    final deadline = deadlineStr != null && deadlineStr.isNotEmpty
        ? DateTime.tryParse(deadlineStr)
        : null;

    final isDoneVal = map[kColIsDone];
    final isDone = isDoneVal is int && isDoneVal == 1;

    return Task(
      id: map[kColId] as int?,
      title: map[kColTitle] as String,
      description: map[kColDescription] as String?,
      deadline: deadline,
      isDone: isDone,
    );
  }
}