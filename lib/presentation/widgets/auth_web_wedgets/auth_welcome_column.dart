import 'package:flutter/material.dart';
import '../../../constant.dart';

class AuthWelcomeColumn extends StatelessWidget {
  final bool isMobile;
  const AuthWelcomeColumn({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: isMobile ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/grad.jpg',
          width: isMobile ? 120 : 200,
          height: isMobile ? 120 : 200,
        ),
        const SizedBox(height: 16),
        Text(
          'Welcome to Yaghmour',
          style: TextStyle(
            color: AppColors.darkBlue,
            fontSize: isMobile ? 20 : 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Login or Register to continue',
          style: TextStyle(
            color: AppColors.darkBlue,
            fontSize: isMobile ? 14 : 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
