import 'package:flutter/material.dart';
import '../../../../themes.dart';

class CustomActionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  /// الزر الأول (مثل إضافة)
  final IconData? actionIcon;
  final String? tooltip;
  final VoidCallback? onActionPressed;

  /// زر إضافي (مثل تعديل)
  final IconData? secondaryIcon;
  final String? secondaryTooltip;
  final VoidCallback? onSecondaryPressed;

  const CustomActionAppBar({
    super.key,
    required this.title,
    this.actionIcon,
    this.tooltip,
    this.onActionPressed,
    this.secondaryIcon,
    this.secondaryTooltip,
    this.onSecondaryPressed,
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
        if (secondaryIcon != null && onSecondaryPressed != null)
          IconButton(
            icon: Icon(secondaryIcon, color: Colors.white),
            tooltip: secondaryTooltip,
            onPressed: onSecondaryPressed,
          ),
        if (actionIcon != null && onActionPressed != null)
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
