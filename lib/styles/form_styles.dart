import 'package:flutter/material.dart';

class FormColors {
  static const bg = Color(0xFF121212);
  static const surface = Color(0xFF1E1E1E);
  static const appBar = Color(0xFF1A1A1A);
  static const border = Color(0xFF2A2A2A);
  static const textPrimary = Colors.white;
  static const textSecondary = Colors.white70;
  static const accent = Colors.teal;
  static const accentBright = Colors.tealAccent;
}

InputDecoration formInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: FormColors.textSecondary),
    filled: true,
    fillColor: FormColors.surface,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: FormColors.border),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: FormColors.accent),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.redAccent),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.redAccent),
      borderRadius: BorderRadius.circular(10),
    ),
    hintStyle: const TextStyle(color: FormColors.textSecondary),
  );
}