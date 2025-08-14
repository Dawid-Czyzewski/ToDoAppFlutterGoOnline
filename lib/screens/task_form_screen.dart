import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/taskForm/task_form_body.dart';
import '../models/task.dart';
import '../styles/form_styles.dart';

class TaskFormScreen extends StatelessWidget {
  final Task? task;

  const TaskFormScreen({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    final titleText = task == null ? 'Dodaj zadanie' : 'Edytuj zadanie';

    return Scaffold(
      backgroundColor: FormColors.bg,
      appBar: AppBar(
        backgroundColor: FormColors.appBar,
        elevation: 0,
        title: Text(
          titleText,
          style: const TextStyle(
            color: FormColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: FormColors.textPrimary),
      ),
      body: TaskFormBody(task: task),
    );
  }
}