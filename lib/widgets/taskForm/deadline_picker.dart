import 'package:flutter/material.dart';
import '../../styles/form_styles.dart';

Future<DateTime?> pickDeadline(BuildContext context, DateTime? initial) async {
  final now = DateTime.now();

  final pickedDate = await showDatePicker(
    context: context,
    initialDate: initial ?? now,
    firstDate: now,
    lastDate: DateTime(now.year + 5),
    builder: (ctx, child) => Theme(
      data: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: FormColors.accent,
          surface: FormColors.surface,
          onSurface: FormColors.textPrimary,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: FormColors.accentBright),
        ), dialogTheme: DialogThemeData(backgroundColor: FormColors.surface),
      ),
      child: child!,
    ),
  );

  if (!context.mounted || pickedDate == null) return null;

  final pickedTime = await showTimePicker(
    context: context,
    initialTime: initial != null
        ? TimeOfDay.fromDateTime(initial)
        : TimeOfDay.now(),
    builder: (ctx, child) => Theme(
      data: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(
          primary: FormColors.accent,
          surface: FormColors.surface,
          onSurface: FormColors.textPrimary,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: FormColors.accentBright),
        ), dialogTheme: DialogThemeData(backgroundColor: FormColors.surface),
      ),
      child: child!,
    ),
  );

  if (!context.mounted || pickedTime == null) return null;

  return DateTime(
    pickedDate.year,
    pickedDate.month,
    pickedDate.day,
    pickedTime.hour,
    pickedTime.minute,
  );
}