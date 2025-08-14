import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/taskForm/deadline_picker.dart';
import 'toast_service.dart';

class TaskFormService {
  static void saveTask({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required Task? existingTask,
    required String title,
    String? description,
    required DateTime? deadline,
  }) {

    if (!(formKey.currentState?.validate() ?? false)) return;

    if (deadline == null) {
      ToastService.showError(context, 'Deadline jest wymagany');
      return;
    }

    formKey.currentState?.save();

    final newTask = Task(
      id: existingTask?.id,
      title: title,
      description: description,
      deadline: deadline,
      isDone: existingTask?.isDone ?? false,
    );

    final provider = Provider.of<TaskProvider>(context, listen: false);
    try {
      if (existingTask == null) {
        provider.addTask(newTask);
        ToastService.showSuccess(context, 'Zadanie dodane');
      } else {
        provider.updateTask(newTask);
        ToastService.showSuccess(context, 'Zadanie zaktualizowane');
      }
      Navigator.pop(context);
    } catch (e) {
      ToastService.showError(context, 'Błąd podczas zapisu zadania');
    }
  }

  static void clearDeadline(ValueSetter<DateTime?> updateState) {
    updateState(null);
  }

  static Future<void> selectDeadline({
    required BuildContext context,
    required DateTime? current,
    required ValueSetter<DateTime?> updateState,
  }) async {
    final picked = await pickDeadline(context, current);
    if (picked != null) updateState(picked);
  }
}