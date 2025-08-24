import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
import '../../../blocs/complaints_bloc/complaint_bloc.dart';
import '../../../blocs/consultation_request_bloc/consultation_request_bloc.dart';
import '../../../blocs/categories/categories_bloc.dart';
import '../../../blocs/common_consultation_bloc/common _consultation_bloc.dart';
import '../../../blocs/delegations_bloc/delegations_bloc.dart';
import '../../../blocs/employee_bloc/employee_bloc.dart';
import '../../../blocs/expenses_bloc/expenses_bloc.dart';
import '../../../blocs/furlough_request_bloc/furlough_request_bloc.dart';
import '../../../blocs/issue_bloc/issues_bloc.dart';

import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../../blocs/legal_books_bloc/legal_books_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../blocs/permission_bloc/permission_bloc.dart';
import '../../../blocs/required_document_bloc/required_document_bloc.dart';
import '../../../blocs/role_bloc/role_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../admin_screens/issues_screens.dart/all_issues_screen.dart';
import '../admin_screens/issues_screens.dart/archived_issues_screen.dart';
import '../ai_chat/chat_with_ai.dart';
import '../all_lawyers_screen.dart';
import '../categories_screen/issue_categories_screen.dart';
import '../common_consulation/list_common_consul.dart';
import '../complaint_screen/list_complaint_screen.dart';
import '../consultation_request/all_consultation_requests_page.dart';
import '../delegations_screen/list_delegation_screen.dart';
import '../expenses_screen/expenses_list_screen.dart';
import '../furloughs/list_furloughs_screen.dart';
import '../home_web/main_page_web.dart';
import '../hr_screen/employee_screens/list_employee_screen.dart';
import '../issue_request/list_issue_requests_screen.dart';
import '../legal_books_screen/logal_book_list.dart';
import '../legal_news_screen/list_legal_news_screen.dart';
import '../permission_screen/list_permission_screen.dart';
import '../report_screen/report_invoices_screen.dart';
import '../required_documents/list_required_document_screen.dart';
import '../role_screen/all_role_screen.dart';
import '../session_type/list_session_type_screen.dart';
import 'drawer_web/custom_drawer_web.dart';
class HomeWebPage extends StatefulWidget {
  const HomeWebPage({super.key});
  @override
  State<HomeWebPage> createState() => _HomeWebPageState();
}
class _HomeWebPageState extends State<HomeWebPage> {
  int selectedPage = 0;

  final List<Widget> pages = [
    const MainScreen(),
    //employee
    BlocProvider(
      create: (context) => EmployeeBloc(),
      child: const  ListEmployeesScreen(),
    ),
    BlocProvider(
      create: (_) => LawyerBloc(),
      child: const AllLawyersScreen(),
    ),
    BlocProvider(
      create: (context) => PermissionBloc(),
      child: const  ListPermissionsScreen(),
    ),
    //issue
    BlocProvider(
      create: (_) => IssuesBloc(),
      child: const AllIssuesScreen(),
    ),

    BlocProvider(
      create: (_) => IssuesBloc(),
      child: const ArchivedIssuesScreen(),
    ),
    BlocProvider(
      create: (_) => DelegationBloc(),
      child: const ListDelegationsScreen(),
    ),
   //issue request
    BlocProvider(
      create: (context) => IssueRequestsBloc(),
      child: const  ListIssueRequestsScreen(),
    ),
    BlocProvider(
      create: (context) => FurloughRequestsBloc(),
      child: const  ListFurloughsScreen(),
    ),
    BlocProvider(
      create: (context) => SessionTypeBloc(),
      child: const  ListSessionTypesScreen(),
    ),
    BlocProvider(
      create: (context) => RequiredDocumentsBloc(),
      child: const  ListRequiredDocumentsScreen(),
    ),
    BlocProvider(
      create: (context) => ConsultationRequestBloc(),
      child: const  AllConsultationRequestsPage(),
    ),

    BlocProvider(
      create: (context) => CommonConsultationBloc(),
      child: const  ListCommonConsultationsScreen(),
    ),
    BlocProvider(
      create: (context) => CategoriesBloc(),
      child: const  ListIssueCategoriesScreen(),
    ),

    const ReportInvoicesScreen(),
    const ChatWithAi(),
  BlocProvider(
  create: (context) => ExpenseBloc(),
  child: const ListExpensesScreen(),
  ),
  BlocProvider(
  create: (context) => LegalBookBloc(),
  child: const ListLegalBooksScreen(),
  ),

  BlocProvider(
  create: (context) => LegalNewsBloc(),
  child: const ListLegalNewsScreen(),
  ),
  BlocProvider(
  create: (context) => RoleBloc(),
  child: const ListRolesScreen(),
  ),
  BlocProvider(
  create: (context) => ComplaintBloc(),
  child: const ListComplaintsScreen(),
  ),





  ];

  void _onDrawerItemSelected(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CustomDrawerWeb(onItemSelected: _onDrawerItemSelected),
          Expanded(child: pages[selectedPage]),
        ],
      ),
    );
  }
}
