import 'package:flutter/material.dart';

import '../../themes.dart';

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
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: getCurrentTheme()['BoldText']),
          ),
          Text(
            value,
            style: TextStyle(color: getCurrentTheme()['BoldText']),
          ),
        ],
      ),
    );
  }
}
