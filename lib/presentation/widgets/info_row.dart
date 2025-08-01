import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  const InfoRow(
      {super.key, required this.title, required this.value, Color? textColor});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          Text(
            '$title ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
