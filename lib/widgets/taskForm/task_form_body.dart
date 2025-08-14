import 'package:flutter/material.dart';
import '../../../models/task.dart';
import '../../../services/task_form_service.dart';
import 'title_field.dart';
import 'description_field.dart';
import 'deadline_field.dart';
import 'submit_button.dart';

class TaskFormBody extends StatefulWidget {
  final Task? task;

  const TaskFormBody({super.key, this.task});

  @override
  State<TaskFormBody> createState() => _TaskFormBodyState();
}

class _TaskFormBodyState extends State<TaskFormBody> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _deadline;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task?.title ?? '';
    _descriptionController.text = widget.task?.description ?? '';
    _deadline = widget.task?.deadline;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateDeadline(DateTime? value) {
    setState(() {
      _deadline = value;
    });
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    TaskFormService.saveTask(
      context: context,
      formKey: _formKey,
      existingTask: widget.task,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      deadline: _deadline,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TitleField(controller: _titleController),
            const SizedBox(height: 16),
            DescriptionField(controller: _descriptionController),
            const SizedBox(height: 16),
            DeadlineField(
              deadline: _deadline,
              onPick: (ctx, current) => TaskFormService.selectDeadline(
                context: ctx,
                current: current,
                updateState: _updateDeadline,
              ),
              onClear: () => TaskFormService.clearDeadline(_updateDeadline),
            ),
            const SizedBox(height: 24),
            SubmitButton(
              isNew: widget.task == null,
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }
}