import '../../models/task.dart';

extension TaskGrouping on List<Task> {
  Map<DateTime, List<Task>> groupByDate() {
    final map = <DateTime, List<Task>>{};

    for (var task in this) {
      final d = task.deadline!;
      final key = DateTime(d.year, d.month, d.day);
      map.putIfAbsent(key, () => []).add(task);
    }

    for (var list in map.values) {
      list.sort((a, b) => a.deadline!.compareTo(b.deadline!));
    }

    final keys = map.keys.toList()..sort();
    return {for (var k in keys) k: map[k]!};
  }
}