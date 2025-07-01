import 'package:flutter/material.dart';

import '../screens/notifications_screen.dart';
import '../../constant.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomHomeAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: AppColors.darkBlue,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white),
          tooltip: 'Notifications',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationsScreen(),
              ),
            );
          },
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage('images/grad.jpg'),
          ),
        ),

      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
