import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool isOverdue;

  const SectionHeader({
    super.key,
    required this.title,
    required this.isOverdue,
  });

  @override
  Widget build(BuildContext context) {
    final color = isOverdue ? Colors.redAccent : Colors.white;
    final style = Theme.of(context).textTheme.titleMedium!;
    return Text(
      title,
      style: style.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: color,
      ),
    );
  }
}