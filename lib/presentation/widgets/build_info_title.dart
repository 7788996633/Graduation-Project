import 'package:flutter/material.dart';

Widget buildInfoTile(IconData icon, String label, String value,
    {Widget? customWidget}) {
  const Color customColor = Color(0xFF002B5B); // AppColors.darkBlue
  const Color valueColor = Color(0xFF0F6829);

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(icon, color: customColor),
        const SizedBox(width: 10),
        Expanded(
          child: customWidget ??
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text: "$label: ",
                      style: const TextStyle(color: customColor),
                    ),
                    TextSpan(
                      text: value,
                      style: const TextStyle(color: valueColor),
                    ),
                  ],
                ),
              ),
        ),
      ],
    ),
  );
}
