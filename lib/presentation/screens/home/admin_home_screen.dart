import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/auth_bloc/auth_bloc.dart';
import 'package:graduation/blocs/payroll_bloc/payroll_bloc.dart';
import '../../../blocs/Consultation_Request_bloc/consultation_request_bloc.dart';
import '../../../blocs/categories/categories_bloc.dart';
import '../../../blocs/common_consultation_bloc/common _consultation_bloc.dart';
import '../../../blocs/complaints_bloc/complaint_bloc.dart';
import '../../../blocs/delegations_bloc/delegations_bloc.dart';
import '../../../blocs/expenses_bloc/expenses_bloc.dart';
import '../../../blocs/furlough_request_bloc/furlough_request_bloc.dart';
import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../../blocs/legal_books_bloc/legal_books_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../blocs/required_document_bloc/required_document_bloc.dart';
import '../../../blocs/role_bloc/role_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../../themes.dart';
import '../../widgets/custom_app_drawer.dart';
import '../../widgets/custom_home_appbar.dart';
import '../../widgets/section_card.dart';
import '../admin_screens/issues_screens.dart/all_issues_screen.dart';
import '../admin_screens/issues_screens.dart/archived_issues_screen.dart';
import '../admin_screens/users_management_screens/modify_users_permissions_screen.dart';
import '../ai_chat/chat_with_ai.dart';
import '../all_lawyers_screen.dart';
import '../categories_screen/issue_categories_screen.dart';
import '../common_consulation/list_common_consul.dart';
import '../complaint_screen/add_complaint_screen.dart';
import '../complaint_screen/list_complaint_screen.dart';
import '../consultation_request/all_consultation_requests_page.dart';
import '../delegations_screen/list_delegation_screen.dart';
import '../expenses_screen/expenses_list_screen.dart';
import '../furloughs/list_furloughs_screen.dart';
import '../issue_request/list_issue_requests_screen.dart';
import '../legal_books_screen/logal_book_list.dart';
import '../legal_books_screen/my_saved_book_list.dart';
import '../legal_news_screen/latest_news_list.dart';
import '../legal_news_screen/list_legal_news_screen.dart';
import '../legal_news_screen/my_saved_news_list.dart';
import '../required_documents/list_required_document_screen.dart';
import '../role_screen/all_role_screen.dart';

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
                builder: (_) => BlocProvider(
                      create: (context) => PayrollBloc(),
                      child: const ModifyUsersPermissionsScreen(),
                    )),
          );
        },
      },
      {
        'title': 'All Cases',
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
        'title': 'Archived Cases',
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
        'title': 'Case Requests',
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
      // {
      //   'title': 'All required decoument ',
      //   'icon': Icons.group,
      //   'onTap': () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (_) => BlocProvider(
      //           create: (_) => RequiredDocumentsBloc(),
      //           child: const ListRequiredDocumentsScreen(),
      //         ),
      //       ),
      //     );
      //   },
      // },
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
        'title': 'Cases Categories',
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
      {
        'title': 'Expenses',
        'icon': Icons.attach_money_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => ExpenseBloc(),
                child: const ListExpensesScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'Library',
        'icon': Icons.book_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => LegalBookBloc(),
                child: const ListLegalBooksScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'News',
        'icon': Icons.newspaper,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => LegalNewsBloc(),
                child: const ListLegalNewsScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'Roles & Permissions',
        'icon': Icons.admin_panel_settings_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => RoleBloc(),
                child: const ListRolesScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'Complaints',
        'icon': Icons.report_problem_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => ComplaintBloc(),
                child: const ListComplaintsScreen(),
              ),
            ),
          );
        },
      },
    ];

    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],
      appBar: const CustomHomeAppBar(title: 'Admin Panel'),
      drawer: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserProfileBloc()..add(ShowUserProfileEvent()),
          ),
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
        ],
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
