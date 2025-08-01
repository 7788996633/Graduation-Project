import 'package:flutter/material.dart';

import '../../../../themes.dart';

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
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color,
      ),
      child: TextFormField(
        style: const TextStyle(
          color: AppColors.white,
        ),
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: AppColors.white,
                )
              : null,
          hintText: text,
          hintStyle: const TextStyle(
            color: AppColors.white,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
        ),
      ),
    );
  }
}
