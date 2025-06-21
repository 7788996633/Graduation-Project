import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // لازم نستوردها لاستخدام kIsWeb
import '../../constant.dart';

class CustomActionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  final IconData? actionIcon;
  final String? tooltip;
  final VoidCallback? onActionPressed;

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
    final isWeb = kIsWeb;
    final backgroundColor = isWeb ? Colors.transparent : AppColors.darkBlue;
    final iconColor = isWeb ? AppColors.darkBlue : Colors.white;
    final textColor = isWeb ? AppColors.darkBlue : Colors.white;

    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: iconColor),
      actions: [
        if (secondaryIcon != null && onSecondaryPressed != null)
          IconButton(
            icon: Icon(secondaryIcon, color: iconColor),
            tooltip: secondaryTooltip,
            onPressed: onSecondaryPressed,
            iconSize: 20,
          ),
        if (actionIcon != null && onActionPressed != null)
          IconButton(
            icon: Icon(actionIcon, color: iconColor),
            tooltip: tooltip,
            onPressed: onActionPressed,
            iconSize: 20,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
