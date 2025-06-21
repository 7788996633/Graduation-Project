import 'package:flutter/material.dart';

import '../../../constant.dart';

class RegisterColumn extends StatelessWidget {
  const RegisterColumn({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already have an account? ",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: const Text(
                "Login",
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
