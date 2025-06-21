import 'package:flutter/material.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../constant.dart';
import '../factories/role_screen.dart';
import 'lawyer_home_screen.dart';

class LawyerHomePage extends StatefulWidget implements RoleScreen {
  const LawyerHomePage({super.key});

  @override
  State<LawyerHomePage> createState() => _LawyerHomePageState();

  @override
  Widget build() {
    throw UnimplementedError();
  }
}

class _LawyerHomePageState extends State<LawyerHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    // الصفحة الرئيسية
    const LawyerHomeScreen(),
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
            selectedColor: AppColors.darkBlue ,
          ),
          // المفضلات
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text("المفضلة"),
            selectedColor: AppColors.darkBlue ,
          ),
          // المواعيد
          SalomonBottomBarItem(
            icon: const Icon(Icons.schedule),
            title: const Text("مواعيدي"),
            selectedColor: AppColors.darkBlue ,
          ),

          SalomonBottomBarItem(
            icon: const Icon(Icons.new_releases),
            title: const Text("الأخبار القانونية"),
            selectedColor: AppColors.darkBlue ,
          ),
        ],
      ),
    );
  }
}
