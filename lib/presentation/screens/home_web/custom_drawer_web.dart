import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.blueGrey[800],
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            'الشعار هنا',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 30),
          drawerItem(context, Icons.home, 'الرئيسية', 0),
          drawerItem(context, Icons.settings, 'الإعدادات', 1),
          drawerItem(context, Icons.person, 'الملف الشخصي', 2),
          drawerItem(context, Icons.logout, 'تسجيل خروج', 3),
        ],
      ),
    );
  }

  Widget drawerItem(BuildContext context, IconData icon, String title, int index) {
    final bool isSelected = selectedIndex == index;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Colors.amber : Colors.white,
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.amber : Colors.white,
          fontSize: 13,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Colors.blueGrey[600], // لون خلفية العنصر عند تحديده
      onTap: () => onItemSelected(index),
    );
  }
}
