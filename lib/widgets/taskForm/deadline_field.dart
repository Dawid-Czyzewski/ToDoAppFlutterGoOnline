import 'package:flutter/material.dart';
import '../../../styles/form_styles.dart';

class DeadlineField extends StatelessWidget {
  final DateTime? deadline;
  final void Function(BuildContext, DateTime?) onPick;
  final VoidCallback onClear;

  const DeadlineField({
    super.key,
    required this.deadline,
    required this.onPick,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final text = deadline == null
        ? 'Brak ustawionego deadline’u'
        : 'Deadline: ${deadline!.toLocal()}'.split('.')[0];
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: deadline != null ? FontWeight.bold : FontWeight.normal,
              color: deadline != null
                  ? FormColors.textPrimary
                  : FormColors.textSecondary,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.clear),
          tooltip: 'Usuń deadline',
          color: FormColors.textSecondary,
          onPressed: deadline == null ? null : onClear,
        ),
        TextButton.icon(
          onPressed: () => onPick(context, deadline),
          icon: const Icon(Icons.event, color: FormColors.accentBright),
          label: const Text(
            'Ustaw deadline',
            style: TextStyle(color: FormColors.accentBright),
          ),
          style: TextButton.styleFrom(
            foregroundColor: FormColors.accentBright,
          ),
        ),
      ],
    );
  }
}