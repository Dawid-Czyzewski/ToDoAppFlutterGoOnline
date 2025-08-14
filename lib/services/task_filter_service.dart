import '../models/task.dart';

class TaskFilterService {
  static List<Task> filterToday(List<Task> tasks) {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfTomorrow = startOfToday.add(const Duration(days: 1));
    return tasks.where((t) =>
      t.deadline != null &&
      _inHalfOpen(t.deadline!, startOfToday, startOfTomorrow)
    ).toList();
  }

  static List<Task> filterTomorrow(List<Task> tasks) {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfTomorrow = startOfToday.add(const Duration(days: 1));
    final startOfDayAfterTomorrow = startOfToday.add(const Duration(days: 2));
    return tasks.where((t) =>
      t.deadline != null &&
      _inHalfOpen(t.deadline!, startOfTomorrow, startOfDayAfterTomorrow)
    ).toList();
  }

  static List<Task> filterThisWeek(List<Task> tasks) {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfDayAfterTomorrow = startOfToday.add(const Duration(days: 2));
    final startOfWeek = startOfToday.subtract(Duration(days: startOfToday.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    return tasks.where((t) =>
      t.deadline != null &&
      t.deadline!.isAfter(startOfDayAfterTomorrow.subtract(const Duration(milliseconds: 1))) &&
      t.deadline!.isBefore(endOfWeek)
    ).toList();
  }

  static bool _inHalfOpen(DateTime d, DateTime from, DateTime to) =>
    (d.isAtSameMomentAs(from) || d.isAfter(from)) && d.isBefore(to);
}