import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../widgets/custom_lawyer_drawer.dart';
import '../../widgets/section_card.dart';
import '../../widgets/custom_home_appbar.dart';
import '../lawyer_screens/lawyer_issues_screens/lawyer_issues_list_screen.dart';
import '../lawyer_screens/lawyer_sessions_screen.dart/lawyer_sessions_screen.dart';

class LawyerHomeScreen extends StatelessWidget {
  const LawyerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': 'All Issues',
        'icon': Icons.gavel,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => IssuesBloc(),
                child: const LawyerIssuesListScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'Sessions',
        'icon': Icons.assignment,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SessionsBloc(),
                child: const LawyerSessionsScreen(),
              ),
            ),
          );
        },
      },
    ];

    return Scaffold(
      appBar: const CustomHomeAppBar(title: 'Lawyer Panel'),
      drawer: BlocProvider(
        create: (context) => LawyerProfileBloc()..add(ShowLawyerProfileEvent()),
        child: const CustomDrawerLawyer(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: sections.map((section) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 24,
              child: SectionCard(
                icon: section['icon'] as IconData,
                title: section['title'] as String,
                onTap: section['onTap'] as VoidCallback,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
