import 'package:flutter/material.dart';
import 'client_requests_table.dart';
import 'custom_main_app_bar.dart';
import 'line_chart.dart';
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
  String selectedLanguage = 'العربية';
  bool isDarkMode = false;

  final GlobalKey _languageKey = GlobalKey();

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void selectLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  void _showLanguageMenu(BuildContext context) async {
    final RenderBox renderBox = _languageKey.currentContext!.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + renderBox.size.height,
        position.dx + renderBox.size.width,
        position.dy,
      ),
      items: const [
        PopupMenuItem<String>(
          value: 'العربية',
          child: Text('العربية'),
        ),
        PopupMenuItem<String>(
          value: 'الإنجليزية',
          child: Text('English'),
        ),
      ],
    ).then((selected) {
      if (selected != null) {
        selectLanguage(selected);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomMainAppBar(
        selectedLanguage: selectedLanguage,
        isDarkMode: isDarkMode,
        onToggleTheme: toggleTheme,
        onSelectLanguage: selectLanguage,
        languageKey: _languageKey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dashboard Overview",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const SummaryCards(),
            const SizedBox(height: 20),

            // ⚙️ Responsive charts layout
            screenWidth > 800
                ? Row(
              children: const [
                Expanded(
                  child: SizedBox(
                    height: 250,
                    child:  LineChartWidget(),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 250,
                    child: TrafficPieChart(),
                  ),
                ),
              ],
            )
                : Column(
              children: const [
                SizedBox(
                  height: 250,
                  child: LineChartWidget(),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 250,
                  child: TrafficPieChart(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const RecentActivity(),
            const SizedBox(height: 20),
// جعل OrdersTable و ClientRequestsTable جنبًا إلى جنب في الشاشات الكبيرة
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
