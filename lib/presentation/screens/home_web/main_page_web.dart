import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/dashboard_bloc/dashboard_bloc.dart';
import '../../../blocs/dashboard_bloc/dashboard_event.dart';
import '../../../blocs/case_type_percentages_bloc/case_type_percentages_bloc.dart';

import '../../../themes.dart';
import 'client_requests_table.dart';
import 'custom_main_app_bar.dart';
import 'revenue_bar_chart.dart';
import 'orders_table.dart';
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

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomMainAppBar(
        isDarkMode: isDarkMode,
        onToggleTheme: toggleTheme,
        languageKey: _languageKey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "dashboard_title".tr(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            BlocProvider(
              create: (context) => DashboardBloc(),
              child: const SummaryCards(),
            ),
            const SizedBox(height: 20),


            screenWidth > 800
                ? Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 250,
                    child: const RevenueBarChart(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 350, // ارتفاع كافي لـ CaseTypePercentagesScreen
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
                  child: const RevenueBarChart(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 350, // نفس الارتفاع في الوضع الضيق
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
            screenWidth > 800
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(child: OrdersTable()),
                SizedBox(width: 20),
                Expanded(child: ClientRequestsTable()),
              ],
            )
                : Column(
              children: const [
                OrdersTable(),
                SizedBox(height: 20),
                ClientRequestsTable(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
