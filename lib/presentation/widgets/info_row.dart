import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.title,
    required this.value,
    this.textColor,
    this.fontSize,
  });

  final String title;
  final String value;
  final Color? textColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final defaultFontSize = fontSize ?? 12.0;
    final defaultColor = textColor ?? Colors.black87;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: defaultFontSize,
              color: defaultColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: defaultFontSize,
                color: defaultColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
