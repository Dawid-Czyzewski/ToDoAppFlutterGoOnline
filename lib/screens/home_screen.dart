import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/home/home_body.dart';
import '../widgets/home/home_bottom_nav.dart';
import '../providers/task_provider.dart';
import '../services/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      Provider.of<TaskProvider>(context, listen: false).loadTasks();
      await NotificationService.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Twoje zadania',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Consumer<TaskProvider>(
          builder: (context, provider, _) {
            final allTasks = [...provider.tasks]..sort((a, b) {
              final aDate = DateTime(a.deadline!.year, a.deadline!.month, a.deadline!.day);
              final bDate = DateTime(b.deadline!.year, b.deadline!.month, b.deadline!.day);
              return aDate.compareTo(bDate);
            });

            return HomeBody(
              currentIndex: _currentIndex,
              allTasks: allTasks,
            );
          },
        ),
      ),
      bottomNavigationBar: HomeBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
