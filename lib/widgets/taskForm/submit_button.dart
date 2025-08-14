import 'package:flutter/material.dart';
import '../../../styles/form_styles.dart';

class SubmitButton extends StatelessWidget {
  final bool isNew;
  final VoidCallback onPressed;

  const SubmitButton({
    super.key,
    required this.isNew,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: FormColors.accent,
          foregroundColor: FormColors.textPrimary,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(isNew ? 'Dodaj' : 'Zapisz'),
      ),
    );
  }
}