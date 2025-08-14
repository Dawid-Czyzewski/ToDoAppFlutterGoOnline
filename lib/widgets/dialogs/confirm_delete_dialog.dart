import 'package:flutter/material.dart';

Future<bool?> showConfirmDeleteDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text(
          'Potwierdź usunięcie',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Czy na pewno chcesz usunąć to zadanie?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text(
              'Anuluj',
              style: TextStyle(color: Colors.tealAccent),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(
              'Usuń',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      );
    },
  );
}