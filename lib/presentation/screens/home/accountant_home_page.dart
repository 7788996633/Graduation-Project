import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../constant.dart';


import 'accountan_home_screen.dart';
import 'hr_home_page.dart';

class AccountantHomePage extends StatefulWidget {
  const AccountantHomePage({super.key});

  @override
  State<AccountantHomePage> createState() => _AccountantHomePageState();
}

class _AccountantHomePageState extends State<AccountantHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const AccountanHomeScreen(),
    const MyTasksPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xFFF2FDF6),
        color: AppColors.darkBlue ,
        buttonBackgroundColor: AppColors.darkBlue ,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.assignment, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
