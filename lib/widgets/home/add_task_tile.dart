import 'package:flutter/material.dart';
import '../../screens/task_form_screen.dart';

class AddTaskTile extends StatelessWidget {
  const AddTaskTile({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          Icons.add,
          color: Colors.black,
        ),
        title: Text(
          'Dodaj nowe zadanie',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Colors.blue,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => TaskFormScreen()),
          );
        },
      ),
    );
  }
}