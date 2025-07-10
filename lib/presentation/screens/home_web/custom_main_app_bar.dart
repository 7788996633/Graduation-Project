import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import '../settings/setting_screen.dart';

class CustomMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final GlobalKey languageKey;

  const CustomMainAppBar({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.languageKey,
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
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 45,
        child: Row(
          children: [
            Expanded(
              child: Text(
                tr('home_page'), // ترجم النص بدل كتابته ثابت
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              tooltip: tr('notifications'),
              icon: const Icon(Icons.notifications, size: 18, color: Colors.black87),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(tr('no_notifications'))),
                );
              },
            ),
            const SizedBox(width: 8),
            TextButton(
              key: languageKey,
              onPressed: () => _showLanguageMenu(context, languageKey),
              child: Text(
                tr('change_language'),
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: isDarkMode ? tr('dark_mode') : tr('light_mode'),
              icon: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                size: 18,
                color: Colors.black87,
              ),
              onPressed: onToggleTheme,
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: tr('settings'),
              icon: const Icon(Icons.settings, size: 18, color: Colors.black87),
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
              icon: const Icon(Icons.logout, size: 18, color: Colors.black87),
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
