import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/taskForm/task_edit_form.dart';
import '../models/task.dart';

class TaskEditScreen extends StatelessWidget {
  final Task? task;

  const TaskEditScreen({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'Nowe zadanie' : 'Edytuj zadanie'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              TaskEditForm.of(context)?.submit();
            },
          ),
        ],
      ),
      body: TaskEditForm(task: task),
    );
  }
}