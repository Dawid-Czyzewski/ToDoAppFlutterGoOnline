import 'package:flutter/material.dart';
import '../../../styles/form_styles.dart';

class DescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: FormColors.textPrimary),
      decoration: formInputDecoration('Opis (opcjonalny)'),
      maxLines: 3,
      cursorColor: FormColors.accent,
    );
  }
}