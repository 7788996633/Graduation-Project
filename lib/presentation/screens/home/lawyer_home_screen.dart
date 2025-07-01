import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../widgets/custom_lawyer_drawer.dart';
import '../../widgets/section_card.dart';
import '../admin_screens/issues_screens.dart/all_issues_screen.dart';
import '../issue_request/list_issue_requests_screen.dart';
import '../../widgets/custom_home_appbar.dart';

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
                child: const AllIssuesScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'Issue Requests',
        'icon': Icons.assignment,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => IssueRequestsBloc(),
                child: const ListIssueRequestsScreen(),
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
