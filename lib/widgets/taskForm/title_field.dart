import 'package:flutter/material.dart';
import '../../../styles/form_styles.dart';

class TitleField extends StatelessWidget {
  final TextEditingController controller;

  const TitleField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: FormColors.textPrimary),
      decoration: formInputDecoration('Tytuł'),
      validator: (value) =>
          value == null || value.trim().isEmpty ? 'Wymagany tytuł' : null,
      cursorColor: FormColors.accent,
    );
  }
}