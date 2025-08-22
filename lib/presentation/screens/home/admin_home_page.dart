import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../themes.dart';
import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../factories/role_screen.dart';
import '../legal_news_screen/latest_news_list.dart';
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
    const AdminHomeScreen(),
    // المفضلات
    BlocProvider(
      create: (context) => LegalNewsBloc(),
      child: const LatestNewsListScreen(),
    ),

    // المواعيد
    BlocProvider(
      create: (context) => LegalNewsBloc(),
      child: const LatestNewsListScreen(),
    ),
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
            selectedColor: AppColors.darkBlue,
          ),
          // المفضلات
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text("المفضلة"),
            selectedColor: AppColors.darkBlue,
          ),
          // المواعيد
          SalomonBottomBarItem(
            icon: const Icon(Icons.article), // أيقونة مناسبة للأخبار
            title: const Text("آخر الأخبار"),
            selectedColor: AppColors.darkBlue,
          ),


          SalomonBottomBarItem(
            icon: const Icon(Icons.new_releases),
            title: const Text("الأخبار القانونية"),
            selectedColor: AppColors.darkBlue,
          ),
        ],
      ),
    );
  }
}
