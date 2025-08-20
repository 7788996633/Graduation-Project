import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/notification_bloc/notification_bloc.dart';
import '../../widgets/notifications_list.dart';
import '../settings/setting_screen.dart';
import '../../../themes.dart'; // يحتوي على متغير isLight

class CustomMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey languageKey;
  final bool isDark;
  final VoidCallback onToggleTheme;

  const CustomMainAppBar({
    super.key,
    required this.languageKey,
    required this.isDark,
    required this.onToggleTheme,
  });

  void _showLanguageMenu(BuildContext context, GlobalKey key) async {
    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + renderBox.size.height,
        position.dx + renderBox.size.width,
        position.dy,
      ),
      items: const [
        PopupMenuItem<String>(
          value: 'ar',
          child: Text('العربية'),
        ),
        PopupMenuItem<String>(
          value: 'en',
          child: Text('English'),
        ),
      ],
    );

    if (selected != null) {
      final locale = Locale(selected);
      await context.setLocale(locale);
    }
  }

  @override
  Widget build(BuildContext context) {
    // لون الأيقونات والنص حسب الوضع
    final iconAndTextColor = isDark ? Colors.white70 : Colors.black87;

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 45,
        child: Row(
          children: [
            Expanded(
              child: Text(
                tr('home_page'),
                style: TextStyle(
                  fontSize: 16,
                  color: iconAndTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              tooltip: tr('notifications'),
              icon: Icon(Icons.notifications, size: 18, color: iconAndTextColor),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => NotificationBloc(),
                      child: const NotificationsList(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            TextButton(
              key: languageKey,
              onPressed: () => _showLanguageMenu(context, languageKey),
              child: Text(
                tr('change_language'),
                style: TextStyle(fontSize: 13, color: iconAndTextColor),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: isDark ? tr('dark_mode') : tr('light_mode'),
              icon: Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                size: 18,
                color: iconAndTextColor,
              ),
              onPressed: onToggleTheme,
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: tr('settings'),
              icon: Icon(Icons.settings, size: 18, color: iconAndTextColor),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: tr('logout'),
              icon: Icon(Icons.logout, size: 18, color: iconAndTextColor),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(tr('logged_out'))),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(45);
}
