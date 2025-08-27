import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../themes.dart';

import '../../../blocs/common_consultation_bloc/common _consultation_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../common_consulation/list_common_consul.dart';
import '../legal_news_screen/latest_news_list.dart';
import 'hr_home_screen.dart';

class HrHomePage extends StatefulWidget {
  const HrHomePage({super.key});

  @override
  State<HrHomePage> createState() => _HrHomePageState();
}

class _HrHomePageState extends State<HrHomePage> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    const HrHomeScreen(),
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
      body: _pages[_pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor:AppColors.scaffold,
        color: AppColors.darkBlue,
        buttonBackgroundColor: AppColors.darkBlue,
          animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: AppColors.white),
          Icon(Icons.article, size: 30, color: AppColors.white),
          Icon(Icons.question_answer, size: 30, color: AppColors.white),
        ],
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: const Center(
        child: Text(
          'Statistics Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class MyTasksPage extends StatelessWidget {
  const MyTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      body: const Center(
        child: Text(
          'My Tasks Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class HrSettingsPage extends StatelessWidget {
  const HrSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('HR Settings Page')),
    );
  }
}

class JobApplicationsPage extends StatelessWidget {
  const JobApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Applications')),
      body: const Center(child: Text('Job Applications Page')),
    );
  }
}

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee List')),
      body: const Center(child: Text('Employee List Page')),
    );
  }
}

class AddEmployeeDataPage extends StatelessWidget {
  const AddEmployeeDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Employee Data')),
      body: const Center(child: Text('Add Employee Data Page')),
    );
  }
}

class ScheduleInterviewsPage extends StatelessWidget {
  const ScheduleInterviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Interviews')),
      body: const Center(child: Text('Schedule Interviews Page')),
    );
  }
}
