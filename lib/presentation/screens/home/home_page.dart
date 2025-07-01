import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../factories/role_screen_facroty.dart';
import '../factories/screen_type.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const screenType = ScreenType.main;
    final screen = RoleScreenFactory.getScreen(
      myRole,
      screenType,
    );
    return screen;
  }
}
