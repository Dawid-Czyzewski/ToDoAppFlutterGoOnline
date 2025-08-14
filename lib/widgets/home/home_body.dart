import 'package:flutter/material.dart';
import 'home_body_view.dart';
import '../../../models/task.dart';
import '../../../screens/stats_screen.dart';

class HomeBody extends StatelessWidget {
  final int currentIndex;
  final List<Task> allTasks;

  const HomeBody({
    super.key,
    required this.currentIndex,
    required this.allTasks,
  });

  @override
  Widget build(BuildContext context) {
    if (currentIndex == 2) {
      return const StatsScreen();
    }

    return HomeBodyView(
      currentIndex: currentIndex,
      allTasks: allTasks,
    );
  }
}