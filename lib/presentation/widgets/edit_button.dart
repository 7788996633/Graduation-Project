import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final Widget destinationScreen;
  final String label;
  final Color backgroundColor;

  const EditButton({
    super.key,
    required this.destinationScreen,
    this.label = 'Edit',
    this.backgroundColor = const Color(0xFF002B5B), // AppColors.darkBlue
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => destinationScreen),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
