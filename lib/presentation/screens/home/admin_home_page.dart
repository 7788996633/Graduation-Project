import 'package:flutter/material.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../factories/role_screen.dart';
import 'admin_home_screen.dart';

class AdminHomePage extends StatefulWidget implements RoleScreen {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();

  @override
  Widget build() {
    throw UnimplementedError();
  }
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    // الصفحة الرئيسية
    AdminHomeScreen(),
    // المفضلات
    const Center(child: Text('مفضلتي')),
    // المواعيد
    const Center(child: Text('مواعيدي')),
    // الأخبار القانونية
    const Center(child: Text('الأخبار القانونية')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // عرض الصفحة بناءً على الـ index المحدد
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          // الواجهة الرئيسية
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("الرئيسية"),
            selectedColor: const Color(0XFF472A0C),
          ),
          // المفضلات
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text("المفضلة"),
            selectedColor: const Color(0XFF472A0C),
          ),
          // المواعيد
          SalomonBottomBarItem(
            icon: const Icon(Icons.schedule),
            title: const Text("مواعيدي"),
            selectedColor: const Color(0XFF472A0C),
          ),

          SalomonBottomBarItem(
            icon: const Icon(Icons.new_releases),
            title: const Text("الأخبار القانونية"),
            selectedColor: const Color(0XFF472A0C),
          ),
        ],
      ),
    );
  }
}
