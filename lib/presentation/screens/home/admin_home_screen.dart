import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../widgets/custom_app_drawer.dart';
import '../../widgets/custom_home_appbar.dart';
import '../../widgets/section_card.dart';
import '../admin_screens/issues_screens.dart/all_issues_screen.dart';
import '../admin_screens/users_management_screens/modify_users_permissions_screen.dart';
import '../all_lawyers_screen.dart';
import '../issue_request/list_issue_requests_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': 'Modify user permissions',
        'icon': Icons.admin_panel_settings,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ModifyUsersPermissionsScreen()),
          );
        },
      },
      {
        'title': 'Issues',
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

      {
        'title': 'All Lawyers',
        'icon': Icons.group,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => LawyerBloc(),
                child: const AllLawyersScreen(),
              ),
            ),
          );
        },
      },
    ];

    return Scaffold(
      appBar: const CustomHomeAppBar(title: 'Admin Panel'),
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
