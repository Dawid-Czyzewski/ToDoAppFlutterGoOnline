import '../models/task.dart';

int Function(Task, Task) get sortByDeadline =>
    (a, b) => a.deadline!.compareTo(b.deadline!);