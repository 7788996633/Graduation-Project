import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/delegations_bloc/delegations_bloc.dart';
import 'package:graduation/presentation/screens/admin_screens/issues_screens.dart/archived_issues_screen.dart';
import 'package:graduation/presentation/screens/ai_chat/chat_with_ai.dart';
import 'package:graduation/presentation/screens/delegations_screen/list_delegation_screen.dart';

import '../../../blocs/Consultation_Request_bloc/consultation_request_bloc.dart';
import '../../../blocs/categories/categories_bloc.dart';
import '../../../blocs/common_consultation_bloc/common _consultation_bloc.dart';
import '../../../blocs/furlough_request_bloc/furlough_request_bloc.dart';
import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../../blocs/required_document_bloc/required_document_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../../themes.dart';
import '../../widgets/custom_app_drawer.dart';
import '../../widgets/custom_home_appbar.dart';
import '../../widgets/section_card.dart';
import '../admin_screens/issues_screens.dart/all_issues_screen.dart';
import '../admin_screens/users_management_screens/modify_users_permissions_screen.dart';
import '../all_lawyers_screen.dart';
import '../categories_screen/issue_categories_screen.dart';
import '../common_consulation/list_common_consul.dart';
import '../consultation_request/all_consultation_requests_page.dart';
import '../furloughs/list_furloughs_screen.dart';
import '../issue_request/list_issue_requests_screen.dart';
import '../required_documents/list_required_document_screen.dart';
import '../session_type/list_session_type_screen.dart';

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
            MaterialPageRoute(
                builder: (_) => const ModifyUsersPermissionsScreen()),
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
        'title': 'Archived issues',
        'icon': Icons.archive_rounded,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => IssuesBloc(),
                child: const ArchivedIssuesScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'All Delegations',
        'icon': Icons.switch_access_shortcut_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => DelegationBloc(),
                child: const ListDelegationsScreen(),
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
      {
        'title': 'All Consultation Requests',
        'icon': Icons.chat_rounded,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => ConsultationRequestBloc(),
                child: const AllConsultationRequestsPage(),
              ),
            ),
          );
        },
      },
      {
        'title': 'common Consultations',
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
        'title': 'All Furloughs',
        'icon': Icons.group,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => FurloughRequestsBloc(),
                child: const ListFurloughsScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'All required decoument ',
        'icon': Icons.group,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => RequiredDocumentsBloc(),
                child: const ListRequiredDocumentsScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'All session type ',
        'icon': Icons.group,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SessionTypeBloc(),
                child: const ListSessionTypesScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'Categories',
        'icon': Icons.group,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => CategoriesBloc(),
                child: const ListIssueCategoriesScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'Chat wit AI',
        'icon': Icons.chat,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ChatWithAi(),
            ),
          );
        },
      },
    ];

    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],
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
