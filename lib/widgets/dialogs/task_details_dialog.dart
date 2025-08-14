import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/task.dart';

Future<void> showTaskDetailsDialog(BuildContext context, Task task) {
  final now = DateTime.now();
  final deadline = task.deadline;
  final isOverdue = deadline != null && deadline.isBefore(now) && !task.isDone;

  return showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      title: Text(
        task.title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (task.description != null && task.description!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                task.description!,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          if (deadline != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '⏰ Deadline: ${DateFormat('dd.MM.yyyy HH:mm').format(deadline)}',
                style: const TextStyle(color: Colors.blueAccent),
              ),
            ),
          Text(
            '🔴 Przeterminowane: ${isOverdue ? 'Tak' : 'Nie'}',
            style: TextStyle(
              color: isOverdue ? Colors.redAccent : Colors.greenAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '✅ Wykonane: ${task.isDone ? 'Tak' : 'Nie'}',
            style: TextStyle(
              color: task.isDone ? Colors.green : Colors.orangeAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Zamknij',
            style: TextStyle(color: Colors.tealAccent),
          ),
        ),
      ],
    ),
  );
}