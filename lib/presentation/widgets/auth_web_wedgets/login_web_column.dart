import 'package:flutter/material.dart';
import '../../../constant.dart';

class LoginColumn extends StatelessWidget {
  final void Function()? onPressed;
  const LoginColumn({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {},
          child: const Text("Forgot password?", style: TextStyle(color: Colors.black54)),
        ),
        const Divider(),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            "Create a new account",
            style: TextStyle(color: AppColors.darkBlue),
          ),
        ),
      ],
    );
  }
}
