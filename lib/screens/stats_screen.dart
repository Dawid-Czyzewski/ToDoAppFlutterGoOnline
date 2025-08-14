import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/stats/stat_card.dart';
import '../utils/task_stats_utils.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    final completed = provider.completedCount;
    final productiveDay = provider.mostProductiveWeekday;
    final todayCount = countTasksForDate(provider.tasks, DateTime.now());
    final weekCount = countTasksForWeek(provider.tasks, DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Statystyki'),
        backgroundColor: const Color(0xFF121212),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            StatCard(
              icon: Icons.check_circle_outline,
              title: 'Wykonane zadania (łącznie)',
              value: '$completed',
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 16),
            StatCard(
              icon: Icons.today,
              title: 'Zadania wykonane dzisiaj',
              value: '$todayCount',
              color: Colors.greenAccent,
            ),
            const SizedBox(height: 16),
            StatCard(
              icon: Icons.calendar_view_week,
              title: 'Zadania w tym tygodniu',
              value: '$weekCount',
              color: Colors.purpleAccent,
            ),
            const SizedBox(height: 16),
            StatCard(
              icon: Icons.star_outline,
              title: 'Najbardziej produktywny dzień',
              value: productiveDay,
              color: Colors.orangeAccent,
            ),
          ],
        ),
      ),
    );
  }
}