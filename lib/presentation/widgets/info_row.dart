import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.title,
    required this.value,
    this.textColor,
    this.fontSize, // جديد
  });

  final String title;
  final String value;
  final Color? textColor;
  final double? fontSize; // جديد

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: fontSize ?? 14, // الحجم الافتراضي 14
              color: textColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: textColor ?? Colors.black87,
                fontSize: fontSize ?? 14, // الحجم الافتراضي 14
              ),
            ),
          ),
        ],
      ),
    );
  }
}
