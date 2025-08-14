import 'package:flutter/foundation.dart';
import '../repositories/task_repository.dart';
import '../models/task.dart';
import '../services/notification_service.dart';
import 'task_sorting.dart';

class TaskProvider with ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  Future<void> loadTasks() async {
    final rawTasks = await _repository.getTasks();
    _tasks = [...rawTasks]..sort(sortByDeadline);
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _repository.insertTask(task);
    await NotificationService.scheduleTaskNotification(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _repository.updateTask(task);
    await NotificationService.scheduleTaskNotification(task);
    await loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await NotificationService.cancelTaskNotification(id);
    await _repository.deleteTask(id);
    await loadTasks();
  }

  Future<void> toggleTaskCompletion(Task task) async {
    final updated = task.copyWith(isDone: !task.isDone);
    await _repository.updateTask(updated);
    await loadTasks();
  }

  int get completedCount => _tasks.where((t) => t.isDone).length;

  String get mostProductiveWeekday {
    final completed = _tasks.where((t) => t.isDone && t.deadline != null);
    if (completed.isEmpty) return 'Brak danych';

    final counts = <int, int>{};
    for (final task in completed) {
      final day = task.deadline!.weekday;
      counts[day] = (counts[day] ?? 0) + 1;
    }

    final bestDay = counts.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
    return _weekdayName(bestDay);
  }

  Map<String, int> get weekdayCompletionStats {
    final stats = {
      'Poniedziałek': 0,
      'Wtorek': 0,
      'Środa': 0,
      'Czwartek': 0,
      'Piątek': 0,
      'Sobota': 0,
      'Niedziela': 0,
    };

    for (final task in _tasks) {
      if (task.isDone && task.deadline != null) {
        final name = _weekdayName(task.deadline!.weekday);
        stats[name] = stats[name]! + 1;
      }
    }

    return stats;
  }

  String _weekdayName(int weekday) {
    const names = [
      'Poniedziałek',
      'Wtorek',
      'Środa',
      'Czwartek',
      'Piątek',
      'Sobota',
      'Niedziela',
    ];
    return names[weekday - 1];
  }
}