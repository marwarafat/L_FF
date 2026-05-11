import 'package:flutter/material.dart';
import '../../../../../../core/styles/app_colors.dart';

class PasswordField extends StatelessWidget {
  final String hint;
  final Function(String)? onChanged;
  final String? error;

  const PasswordField({
    super.key,
    required this.hint,
    this.onChanged,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        errorText: error,
        hintText: hint,
        hintStyle: const TextStyle(
          color: AppColors.greyMedium,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: AppColors.white,
        suffixIcon: const Icon(Icons.visibility_off, color: AppColors.border),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
