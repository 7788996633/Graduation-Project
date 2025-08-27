import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../themes.dart';


import '../../../blocs/common_consultation_bloc/common _consultation_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../common_consulation/list_common_consul.dart';
import '../legal_news_screen/latest_news_list.dart';
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
    BlocProvider(
      create: (context) => LegalNewsBloc(),
      child: const LatestNewsListScreen(),
    ),

    BlocProvider(
      create: (context) => CommonConsultationBloc(),
      child: const ListCommonConsultationsScreen(),
    ),

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
          Icon(Icons.article, size: 30, color: AppColors.white),
          Icon(Icons.question_answer, size: 30, color: AppColors.white),
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
