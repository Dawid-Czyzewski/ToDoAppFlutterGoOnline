import '../models/task.dart';

int completedCount(List<Task> tasks) {
  return tasks.where((t) => t.isDone).length;
}

String mostProductiveWeekday(List<Task> tasks) {
  final completed = tasks.where((t) => t.isDone && t.deadline != null);
  if (completed.isEmpty) return 'Brak danych';

  final counts = <int, int>{};
  for (final task in completed) {
    final day = task.deadline!.weekday;
    counts[day] = (counts[day] ?? 0) + 1;
  }

  final bestDay = counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  return _weekdayName(bestDay);
}

Map<String, int> weekdayCompletionStats(List<Task> tasks) {
  final stats = {
    'Poniedziałek': 0,
    'Wtorek': 0,
    'Środa': 0,
    'Czwartek': 0,
    'Piątek': 0,
    'Sobota': 0,
    'Niedziela': 0,
  };

  for (final task in tasks) {
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