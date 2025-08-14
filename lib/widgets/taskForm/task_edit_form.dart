import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../models/task.dart';
import '../../../providers/task_provider.dart';

class TaskEditForm extends StatefulWidget {
  final Task? task;

  const TaskEditForm({super.key, this.task});

  static TaskEditFormState? of(BuildContext context) {
    return context.findAncestorStateOfType<TaskEditFormState>();
  }

  @override
  State<TaskEditForm> createState() => TaskEditFormState();
}

class TaskEditFormState extends State<TaskEditForm> {
  final _formKey = GlobalKey<FormState>();

  late String _title;
  String? _description;
  late DateTime _deadline;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _title = widget.task?.title ?? '';
    _description = widget.task?.description;
    _deadline = widget.task?.deadline ?? now.add(const Duration(hours: 1));
  }

  Future<void> _pickDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_deadline),
    );
    if (pickedTime == null) return;

    setState(() {
      _deadline = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  void submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final provider = Provider.of<TaskProvider>(context, listen: false);

      if (widget.task == null) {
        final newTask = Task(
          title: _title,
          description: _description,
          deadline: _deadline,
        );
        provider.addTask(newTask);
      } else {
        final updated = widget.task!.copyWith(
          title: _title,
          description: _description,
          deadline: _deadline,
        );
        provider.updateTask(updated);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deadlineStr = DateFormat('yyyy-MM-dd HH:mm').format(_deadline);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              initialValue: _title,
              decoration: const InputDecoration(labelText: 'Tytuł'),
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Podaj tytuł' : null,
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              initialValue: _description,
              decoration:
                  const InputDecoration(labelText: 'Opis (opcjonalny)'),
              maxLines: 3,
              onSaved: (value) => _description = value,
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Deadline'),
              subtitle: Text(deadlineStr),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDateTime,
            ),
          ],
        ),
      ),
    );
  }
}