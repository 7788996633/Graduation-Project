import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/common_consultation_bloc/common _consultation_bloc.dart';
import '../../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../blocs/job_application/job_application_bloc.dart';
import '../../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../widgets/custom_app_drawer.dart';
import '../../widgets/section_card.dart';

import '../common_consulation/list_common_consul.dart';
import '../hr_screen/job_application/job_application_list_screen.dart';
import '../hr_screen/job_application/my_application_job_list.dart';
import '../issue_request/add_issue_request.dart';
import '../settings/setting_screen.dart';
import '../../widgets/custom_home_appbar.dart';
import '../user_screens/user_issues_screens/user_issues_screens.dart';
import '../user_screens/user_sessions_screen/user_session_screens.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

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
                child: const UserIssuesScreens(),
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
                child: const UserSessionScreens(),
              ),
            ),
          );
        },
      },
      {
        'title': 'Submit Issue Request',
        'icon': Icons.add_circle,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => IssueRequestsBloc(),
                child: const AddIssueRequestScreen(),
              ),
            ),
          );
        },
      },


      {
        'title': 'list Job application ',
        'icon': Icons.contact_support,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => JobApplicationBloc(),
                child: const ListJobApplicationsScreen(),
              ),
            ),
          );
        },},

      {
        'title': 'Common Consultations',
        'icon': Icons.question_answer_rounded,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => CommonConsultationBloc(),
                child: const ListCommonConsultationsScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'my Job application ',
        'icon': Icons.contact_support,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => JobApplicationBloc(),
                child: const MyListJobApplicationsScreen(),
              ),
            ),
          );
        },},
      {
        'title': 'Submit Complaint',
        'icon': Icons.report_problem,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
        },
      },
      {
        'title': 'FAQs & Legal Terms',
        'icon': Icons.question_answer,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
        },
      },
      {
        'title': 'Submit Training Request',
        'icon': Icons.school,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
        },
      },
    ];

    return Scaffold(
      appBar: const CustomHomeAppBar(title: 'User Panel'),
      drawer: BlocProvider(
        create: (context) => UserProfileBloc()..add(ShowUserProfileEvent()),
        child: const CustomAppDrawer(),
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
