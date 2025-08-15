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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon != null
              ? Icon(
            icon,
            color: AppColors.darkBlue,
          )
              : null,
          labelText: text,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: TextStyle(
            color: AppColors.darkBlue,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.white.withOpacity(0.9),
            shadows: const [
              Shadow(
                color: Colors.white,
                offset: Offset(0, 0),
                blurRadius: 5,
              ),
            ],
          ),
          filled: true,
          fillColor: color,
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey.shade300, // هنا لون الحواف رمادي فاتح
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.darkBlue,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
