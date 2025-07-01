import 'package:flutter/material.dart';

import '../../constant.dart';

class CustomActionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData actionIcon;
  final String tooltip;
  final VoidCallback onActionPressed;

  const CustomActionAppBar({
    super.key,
    required this.title,
    required this.actionIcon,
    required this.tooltip,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      elevation: 8,
      backgroundColor: AppColors.darkBlue,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: Icon(actionIcon, color: Colors.white),
          tooltip: tooltip,
          onPressed: onActionPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
