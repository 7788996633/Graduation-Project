import 'package:flutter/material.dart';

import '../../constant.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({
    super.key,
    required this.text,
    required this.controller,
    this.validator,
    required this.color,
    this.icon,
  });

  final String text;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon) : null,
          hintText: text,
          hintStyle: const TextStyle(
            color: AppColors.darkBlue,
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
