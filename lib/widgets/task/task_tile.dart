import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/task.dart';
import '../../../providers/task_provider.dart';
import '../../../screens/task_form_screen.dart';
import '../../../extensions/date_time_extensions.dart';
import '../dialogs/confirm_delete_dialog.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onViewDetails;

  const TaskTile({
    super.key,
    required this.task,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isOverdue = task.deadline!.isBefore(now) && !task.isDone;
    final provider = Provider.of<TaskProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.3 * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              task.title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isOverdue ? Colors.redAccent : Colors.white,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              task.deadline!.toHHMM(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          IconButton(
            icon: Icon(
              task.isDone
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: task.isDone ? Colors.green : Colors.grey,
            ),
            onPressed: () {
              provider.toggleTaskCompletion(task);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    task.isDone
                        ? 'Zadanie oznaczone jako niewykonane'
                        : 'Zadanie oznaczone jako wykonane',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.remove_red_eye, color: Colors.white70),
            onPressed: onViewDetails,
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white70),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TaskFormScreen(task: task),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () async {
              final confirmed = await showConfirmDeleteDialog(context);
              if (confirmed == true) {
                provider.deleteTask(task.id!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Zadanie zostało usunięte'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}