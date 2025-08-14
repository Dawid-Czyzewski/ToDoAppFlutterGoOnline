import 'package:flutter/material.dart';
import '../../../models/task.dart';
import '../home/section_header.dart';
import 'task_tile.dart';

class TaskSectionWidget extends StatelessWidget {
  final String title;
  final List<Task> tasks;
  final void Function(Task) onViewDetails;

  const TaskSectionWidget({
    super.key,
    required this.title,
    required this.tasks,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isOverdueSection = tasks.isNotEmpty &&
        tasks.every((t) => t.deadline!.isBefore(now) && !t.isDone);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title, isOverdue: isOverdueSection),
          const SizedBox(height: 8),
          if (tasks.isEmpty)
            Center(
              child: Text(
                'Brak zadań',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          else
            ...tasks.map((task) {
              return TaskTile(
                task: task,
                onViewDetails: () => onViewDetails(task),
              );
            }),
        ],
      ),
    );
  }
}