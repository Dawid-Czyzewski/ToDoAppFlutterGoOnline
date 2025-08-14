import '../../models/task.dart';

int countTasksForDate(List<Task> tasks, DateTime date) {
  return tasks.where((task) =>
    task.isDone &&
    task.deadline != null &&
    task.deadline!.year == date.year &&
    task.deadline!.month == date.month &&
    task.deadline!.day == date.day
  ).length;
}

int countTasksForWeek(List<Task> tasks, DateTime date) {
  final start = date.subtract(Duration(days: date.weekday - 1));
  final end = start.add(const Duration(days: 6));

  return tasks.where((task) =>
    task.isDone &&
    task.deadline != null &&
    task.deadline!.isAfter(start.subtract(const Duration(seconds: 1))) &&
    task.deadline!.isBefore(end.add(const Duration(days: 1)))
  ).length;
}