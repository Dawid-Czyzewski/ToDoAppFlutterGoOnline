import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final void Function(bool?) onToggleComplete;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggleComplete,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final String subtitle = [
      if (task.description != null && task.description!.isNotEmpty)
        task.description!,
      if (task.deadline != null)
        'Deadline: ${DateFormat('yyyy-MM-dd HH:mm').format(task.deadline!)}',
    ].join(' • ');

    return ListTile(
      leading: Checkbox(
        value: task.isDone,
        onChanged: onToggleComplete,
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
          color: task.isDone ? Colors.grey : null,
        ),
      ),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'edit') {
            onEdit();
          } else if (value == 'delete') {
            _showDeleteDialog(context);
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'edit',
            child: Text('Edytuj'),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Text('Usuń'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Usuń zadanie'),
        content: const Text('Czy na pewno chcesz usunąć to zadanie?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Anuluj'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onDelete();
            },
            child: const Text('Usuń'),
          ),
        ],
      ),
    );
  }
}