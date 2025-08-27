// main_screen.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law/presentation/screens/home_web/page_navigation_screen.dart';

import '../../../blocs/Consultation_Request_bloc/consultation_request_bloc.dart';
import '../../../blocs/categories/categories_bloc.dart';
import '../../../blocs/dash_bloc/dash_bloc.dart';
import '../../../blocs/dash_bloc/dash_event.dart';
import '../../../blocs/dashboard_bloc/dashboard_bloc.dart';
import '../../../blocs/case_type_percentages_bloc/case_type_percentages_bloc.dart';

import '../../../blocs/employee_bloc/employee_bloc.dart';
import '../../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../../blocs/permission_bloc/permission_bloc.dart';
import '../../../blocs/role_bloc/role_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/user_bloc/user_bloc.dart';
import '../../../themes.dart';
import '../all_lawyers_screen.dart';
import '../all_users_list.dart';
import '../categories_screen/issue_categories_screen.dart';
import '../hr_screen/employee_screens/list_employee_screen.dart';
import '../permission_screen/list_permission_screen.dart';
import '../role_screen/all_role_screen.dart';
import '../session_type/list_session_type_screen.dart';
import 'client_requests_table.dart';
import 'custom_main_app_bar.dart';
import 'revenue_bar_chart.dart';
import 'consultation_request_table.dart';
import 'pie_chart.dart';
import 'recent_activity.dart';
import 'summary_cards.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isDarkMode = false;
  final GlobalKey _languageKey = GlobalKey();
  int selectedIndex = -1;

  void toggleTheme() {
    setState(() => isDarkMode = !isDarkMode);
  }

  final pages = [
    "Users",
    "Employees",
    "Roles",
    "Permissions",
    "Session Type",
    "Issue Category",
  ];

  void navigateToPage(int index) {
    late Widget page;

    switch (pages[index]) {
      case "Users":
        page = BlocProvider(
          create: (context) => UserBloc(),
          child: const ListUsersScreen(),
        );
        break;
      case "Employees":
        page = BlocProvider(
          create: (context) => EmployeeBloc(),
          child: const ListEmployeesScreen(),
        );
        break;
      case "Lawyers":
        page = BlocProvider(
          create: (context) => LawyerBloc(),
          child: const AllLawyersScreen(),
        );
        break;
      case "Roles":
        page = BlocProvider(
    create: (context) => RoleBloc(),
    child: const ListRolesScreen(),
    );
        break;
      case "Permissions":
        page = BlocProvider(
          create: (context) => PermissionBloc(),
          child: const ListPermissionsScreen(),
        );
        break;
      case "Session Type":
        page = BlocProvider(
    create: (context) => SessionTypeBloc(),
    child: const  ListSessionTypesScreen(),
    );
        break;
      case "Issue Category":
        page = BlocProvider(
    create: (context) => CategoriesBloc(),
    child: const  ListIssueCategoriesScreen(),
    );
        break;

      default:
        page = const MainScreen();
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final scaffoldColor = isDarkMode ? Colors.grey[700] : AppColors.scaffold;
    final textAndIconColor = isDarkMode ? Colors.white70 : Colors.black87;
    final cardBackgroundColor = AppColors.white;

    Widget chartSection() {
      if (screenWidth > 800) {
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 250,
                child: BlocProvider(
                  create: (_) => DashBloc()..add(FetchDashData()),
                  child: const RevenueBarChart(),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: SizedBox(
                height: 350,
                child: BlocProvider(
                  create: (_) => CaseTypeBloc(),
                  child: const CaseTypePercentagesScreen(),
                ),
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: [
            SizedBox(
              height: 250,
              child: BlocProvider(
                create: (_) => DashBloc()..add(FetchDashData()),
                child: const RevenueBarChart(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 350,
              child: BlocProvider(
                create: (_) => CaseTypeBloc(),
                child: const CaseTypePercentagesScreen(),
              ),
            ),
          ],
        );
      }
    }

    Widget tablesSection() {
      if (screenWidth > 800) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: BlocProvider(
                  create: (_) => ConsultationRequestBloc(),
                  child: ConsultationRequestTable(cardColor: AppColors.white),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ClientRequestsTable(cardColor: cardBackgroundColor),
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: BlocProvider(
                create: (_) => ConsultationRequestBloc(),
                child: ConsultationRequestTable(cardColor: AppColors.white),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ClientRequestsTable(cardColor: cardBackgroundColor),
            ),
          ],
        );
      }
    }

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: CustomMainAppBar(
        languageKey: _languageKey,
        isDark: isDarkMode,
        onToggleTheme: toggleTheme,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "dashboard_title".tr(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textAndIconColor,
              ),
            ),
            const SizedBox(height: 20),
            NavigationPagesRow(
              pages: pages, // قائمة أسماء الصفحات اللي راح تظهر في الصف الأفقي
              selectedIndex: selectedIndex, // رقم الصفحة المحددة حاليًا
              onPageSelected: (index) {      // الدالة اللي تنفذ عند الضغط على أي صفحة
                setState(() => selectedIndex = index); // تحديث الصفحة المحددة
                navigateToPage(index);                 // الانتقال أو تنفيذ شيء عند اختيار الصفحة
              },
              scaffoldColor: scaffoldColor!,     // لون خلفية الكارد غير المحدد
            ),
            const SizedBox(height: 20),
            BlocProvider(
              create: (_) => DashboardBloc(),
              child: SummaryCards(cardColor: cardBackgroundColor),
            ),
            const SizedBox(height: 20),
            chartSection(),
            const SizedBox(height: 20),
            const RecentActivity(),
            const SizedBox(height: 20),
            tablesSection(),
          ],
        ),
      ),
    );
  }
}

// صفحات فرعية ثابتة
class SessionTypePage extends StatelessWidget {
  const SessionTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Session Type Page")),
      body: const Center(child: Text("This is the Session Type Page")),
    );
  }
}

class IssueCategoryPage extends StatelessWidget {
  const IssueCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Issue Category Page")),
      body: const Center(child: Text("This is the Issue Category Page")),
    );
  }
}
