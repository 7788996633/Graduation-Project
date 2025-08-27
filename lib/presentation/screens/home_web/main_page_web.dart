// main_screen.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:law/presentation/screens/home_web/page_navigation_screen.dart';

import '../../../blocs/Consultation_Request_bloc/consultation_request_bloc.dart';
import '../../../blocs/dash_bloc/dash_bloc.dart';
import '../../../blocs/dashboard_bloc/dashboard_bloc.dart';
import '../../../blocs/case_type_percentages_bloc/case_type_percentages_bloc.dart';

import '../../../themes.dart';
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
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  final pages = [
    "Role",
    "Permission",
    "Session Type",
    "Issue Category",
  ];

  void navigateToPage(int index) {
    Widget page;
    switch (pages[index]) {
      case "Role":
        page = const RolePage();
        break;
      case "Permission":
        page = const PermissionPage();
        break;
      case "Session Type":
        page = const SessionTypePage();
        break;
      case "Issue Category":
        page = const IssueCategoryPage();
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
            // Main Title
            Text(
              "dashboard_title".tr(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textAndIconColor,
              ),
            ),
            const SizedBox(height: 20),

            // NavigationPagesRow
            NavigationPagesRow(
              pages: pages,
              selectedIndex: selectedIndex,
              onPageSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
                navigateToPage(index); // الانتقال عند الضغط
              },
              scaffoldColor: scaffoldColor!,
              textAndIconColor: textAndIconColor,
            ),

            const SizedBox(height: 20),

            // Summary Cards
            BlocProvider(
              create: (context) => DashboardBloc(),
              child: SummaryCards(cardColor: cardBackgroundColor),
            ),
            const SizedBox(height: 20),

            // Revenue & Pie Chart Section
            screenWidth > 800
                ? Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 250,
                    child: BlocProvider(
                      create: (context) => DashBloc(),
                      child: const RevenueBarChart(),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 350,
                    child: BlocProvider(
                      create: (context) => CaseTypeBloc(),
                      child: const CaseTypePercentagesScreen(),
                    ),
                  ),
                ),
              ],
            )
                : Column(
              children: [
                SizedBox(
                  height: 250,
                  child: BlocProvider(
                    create: (context) => DashBloc(),
                    child: const RevenueBarChart(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 350,
                  child: BlocProvider(
                    create: (context) => CaseTypeBloc(),
                    child: const CaseTypePercentagesScreen(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const RecentActivity(),
            const SizedBox(height: 20),

            // Consultation & Client Requests Tables
            screenWidth > 800
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: BlocProvider(
                      create: (_) => ConsultationRequestBloc(),
                      child: ConsultationRequestTable(
                        cardColor: AppColors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ClientRequestsTable(
                      cardColor: cardBackgroundColor,
                    ),
                  ),
                ),
              ],
            )
                : Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: BlocProvider(
                    create: (_) => ConsultationRequestBloc(),
                    child: ConsultationRequestTable(
                      cardColor: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ClientRequestsTable(
                    cardColor: cardBackgroundColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// صفحات فرعية لكل خيار
class RolePage extends StatelessWidget {
  const RolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Role Page")),
      body: const Center(child: Text("This is the Role Page")),
    );
  }
}

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Permission Page")),
      body: const Center(child: Text("This is the Permission Page")),
    );
  }
}

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
