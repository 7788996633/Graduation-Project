import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/dashboard_bloc/dashboard_bloc.dart';
import '../../../blocs/dashboard_bloc/dashboard_event.dart';
import '../../../blocs/dashboard_bloc/dashboard_state.dart';

class SummaryCards extends StatefulWidget {
  final Color cardColor;  // تمرير لون الخلفية للبطاقات (يمكن تلوين حسب الوضع)

  const SummaryCards({super.key, required this.cardColor});

  @override
  State<SummaryCards> createState() => _SummaryCardsState();
}

class _SummaryCardsState extends State<SummaryCards> {
  int? openCases;
  int? totalClients;
  int? sessionsThisMonth;
  bool isLoading = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<DashboardBloc>();
    bloc.add(FetchDashboardData());
  }

  @override
  Widget build(BuildContext context) {
    // النصوص تستخدم لون ثابت هنا، أو ممكن تضيف خاصية للون النص لو حبيت
    final titleTextColor = widget.cardColor.computeLuminance() < 0.5
        ? Colors.white70
        : Colors.black54;

    return BlocListener<DashboardBloc, DashboardState>(
      listener: (context, state) {
        setState(() {
          if (state is DashboardLoading) {
            isLoading = true;
            hasError = false;
          } else if (state is DashboardFail) {
            isLoading = false;
            hasError = true;
          } else if (state is DashboardSuccess) {
            isLoading = false;
            hasError = false;
            openCases = state.openCases;
            totalClients = state.totalClients;
            sessionsThisMonth = state.sessionsThisMonth;
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            Expanded(
              child: SummaryCard(
                title: "Open Cases",
                amount: _formatAmount(openCases),
                color: Colors.red,
                backgroundColor: widget.cardColor,
                titleColor: titleTextColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SummaryCard(
                title: "Total Clients",
                amount: _formatAmount(totalClients),
                color: Colors.indigo,
                backgroundColor: widget.cardColor,
                titleColor: titleTextColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SummaryCard(
                title: "Sessions This Month",
                amount: _formatAmount(sessionsThisMonth),
                color: Colors.orange,
                backgroundColor: widget.cardColor,
                titleColor: titleTextColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SummaryCard(
                title: "Total Revenue",
                amount: "\$12,340.00",
                color: Colors.green,
                backgroundColor: widget.cardColor,
                titleColor: titleTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatAmount(int? value) {
    if (isLoading) return "...";
    if (hasError) return "Error";
    if (value == null) return "-";
    return value.toString();
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final Color backgroundColor;
  final Color titleColor;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    required this.backgroundColor,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.computeLuminance() < 0.5
                ? Colors.black54
                : Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
