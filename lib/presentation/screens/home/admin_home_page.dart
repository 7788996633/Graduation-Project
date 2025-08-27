import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../themes.dart';
import '../../../blocs/common_consultation_bloc/common _consultation_bloc.dart';

import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../../constant.dart';
import '../common_consulation/list_common_consul.dart';
import '../factories/role_screen.dart';
import '../legal_news_screen/latest_news_list.dart';
import '../user_screens/user_profile_screens/user_profile_screen.dart';
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

    // آخر الأخبار
    BlocProvider(
      create: (context) => LegalNewsBloc(),
      child: const LatestNewsListScreen(),
    ),


    BlocProvider(
      create: (_) => CommonConsultationBloc(),
      child: const ListCommonConsultationsScreen(),
    ),

    // الملف الشخصي
    BlocProvider(
      create: (context) => UserProfileBloc(),
      child: UserProfileScreen(userId: myUserId),
    ),
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
          // الصفحة الرئيسية
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_filled),
            title: const Text("الرئيسية"),
            selectedColor: AppColors.darkBlue,
          ),

          // آخر الأخبار
          SalomonBottomBarItem(
            icon: const Icon(Icons.newspaper),
            title: const Text("آخر الأخبار"),
            selectedColor: AppColors.darkBlue,
          ),

          // الاستشارات / الأخبار القانونية
          SalomonBottomBarItem(
            icon: const Icon(Icons.chat_bubble_outline),
            title: const Text("الاستشارات"),
            selectedColor: AppColors.darkBlue,
          ),

          // الملف الشخصي
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("ملفي"),
            selectedColor: AppColors.darkBlue,
          ),
        ],
      ),
    );
  }
}
