import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../themes.dart';
import '../../../blocs/common_consultation_bloc/common _consultation_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../common_consulation/list_common_consul.dart';
import '../legal_news_screen/latest_news_list.dart';
import 'user_home_screen.dart';


class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _MainClientPageState();
}

class _MainClientPageState extends State<UserHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const UserHomeScreen(),
    BlocProvider(
      create: (context) => LegalNewsBloc(),
      child: const LatestNewsListScreen(),
    ),

    BlocProvider(
      create: (context) => CommonConsultationBloc(),
      child: const ListCommonConsultationsScreen(),
    ),


  ];

  final List<Widget> _items = [

    const Icon(Icons.home_filled, size: 30),        // الصفحة الرئيسية
    const Icon(Icons.newspaper, size: 30),          // الأخبار القانونية
    const Icon(Icons.chat_bubble_outline, size: 30) // الاستشارات الشائعة
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor:AppColors.white,
        color: AppColors.darkBlue ,
        buttonBackgroundColor: AppColors.white,
        height: 60,
        items: _items,
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
