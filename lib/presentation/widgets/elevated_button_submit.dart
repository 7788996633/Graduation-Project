import 'package:flutter/material.dart';
import '../../constant.dart';

class CustomElevatedButtonSubmit extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double elevation;
  final BorderRadiusGeometry borderRadius;

  const CustomElevatedButtonSubmit({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppColors.darkBlue,
    this.textColor = AppColors.white,
    this.elevation = 5,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        elevation: elevation,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
