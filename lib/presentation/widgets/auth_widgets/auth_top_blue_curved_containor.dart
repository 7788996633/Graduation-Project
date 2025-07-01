import 'package:flutter/material.dart';

import '../../../constant.dart';

class AuthTopBlueCurvedContainor extends StatelessWidget {
  const AuthTopBlueCurvedContainor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.darkBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
