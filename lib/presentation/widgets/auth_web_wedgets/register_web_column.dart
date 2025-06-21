import 'package:flutter/material.dart';
import '../../../constant.dart';

class RegisterColumn extends StatelessWidget {
  final void Function()? onPressed;
  const RegisterColumn({super.key, this.onPressed});

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
              style: TextStyle(color: Colors.black54),
            ),
            TextButton(
              onPressed: onPressed,
              child: const Text(
                "Login",
                style: TextStyle(
                  color: AppColors.darkBlue,
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
