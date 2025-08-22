import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: double.infinity,
      color: const Color(0xFF1E2A38),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            'Lector.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: ListView(
              children: [
                sidebarItem(Icons.dashboard, "Dashboard"),
                sidebarItem(Icons.widgets, "Widgets"),
                sidebarItem(Icons.list_alt, "UI Elements"),
                sidebarItem(Icons.edit, "Editors"),
                sidebarItem(Icons.table_chart, "Tables"),
                sidebarItem(Icons.email, "Email"),
                sidebarItem(Icons.settings, "Settings"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sidebarItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {},
    );
  }
}
