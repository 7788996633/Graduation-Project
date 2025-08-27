import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law/blocs/common_consultation_bloc/common%20_consultation_bloc.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../themes.dart';
import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../../constant.dart';
import '../common_consulation/list_common_consul.dart';
import '../factories/role_screen.dart';
import '../legal_news_screen/latest_news_list.dart';
import '../user_screens/user_profile_screens/user_profile_screen.dart';
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
    BlocProvider(
      create: (context) => LegalNewsBloc(),
      child: const LatestNewsListScreen(),
    ),

    BlocProvider(
      create: (context) => CommonConsultationBloc(),
      child: const ListCommonConsultationsScreen(),
    ),

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

          SalomonBottomBarItem(
            icon: const Icon(Icons.home_filled), // أيقونة للرئيسية أكثر وضوحًا
            title: const Text("الرئيسية"),
            selectedColor: AppColors.darkBlue,
          ),

          SalomonBottomBarItem(
            icon: const Icon(Icons.article_outlined), // أيقونة للأخبار
            title: const Text("اخر الاخبار"),
            selectedColor: AppColors.darkBlue,
          ),

          SalomonBottomBarItem(
            icon: const Icon(Icons.chat_bubble_outline), // أيقونة للاستشارات
            title: const Text("الاستشارات الشائعة"),
            selectedColor: AppColors.darkBlue,
          ),

          SalomonBottomBarItem(
            icon: const Icon(Icons.person_outline), // أيقونة لصفحتي
            title: const Text("صفحتي"),
            selectedColor: AppColors.darkBlue,
          ),
        ],
      ),
    );
  }
}
