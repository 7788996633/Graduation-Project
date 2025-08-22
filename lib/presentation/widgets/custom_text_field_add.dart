import 'package:flutter/material.dart';

class CustomTextFieldAdd extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  final bool obscureText;
  final int? maxLines;
  final String? Function(String?)? validator;
  final bool filled;
  final Color? fillColor;
  final VoidCallback? onTap;       // إضافة onTap اختيارية
  final bool readOnly;             // إضافة readOnly اختيارية مع قيمة افتراضية false

  const CustomTextFieldAdd({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines,
    this.validator,
    this.filled = false,
    this.fillColor = Colors.white,
    this.onTap,                  // onTap اختياري
    this.readOnly = false,       // readOnly اختياري، افتراضي false
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      readOnly: readOnly,       // تطبيق readOnly
      onTap: onTap,             // تطبيق onTap
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: filled,
        fillColor: fillColor,
      ),
    );
  }
}
