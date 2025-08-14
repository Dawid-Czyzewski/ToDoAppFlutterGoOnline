import 'package:flutter/material.dart';
import '../../../models/task.dart';
import '../task_grouping.dart';
import '../date_label_formatter.dart';
import '../weather/weather_widget.dart';
import 'add_task_tile.dart';
import '../task/task_section_widget.dart';
import '../dialogs/task_details_dialog.dart';

class HomeBodyView extends StatelessWidget {
  final int currentIndex;
  final List<Task> allTasks;

  const HomeBodyView({
    super.key,
    required this.currentIndex,
    required this.allTasks,
  });

  @override
  Widget build(BuildContext context) {
    final tasks = allTasks
        .where((t) => t.deadline != null)
        .where((t) => currentIndex == 0 ? !t.isDone : t.isDone)
        .toList();

    final grouped = tasks.groupByDate();
    final theme = Theme.of(context);

    return ListView(
      children: [
        const WeatherWidget(),
        if (currentIndex == 0) const AddTaskTile(),
        if (tasks.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text(
                'Brak zadań',
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          )
        else
          ...grouped.entries.map((e) {
            return TaskSectionWidget(
              title: e.key.label,
              tasks: e.value,
              onViewDetails: (task) =>
                  showTaskDetailsDialog(context, task),
            );
          }),
      ],
    );
  }
}