import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/dashboard_bloc/dashboard_bloc.dart';
import '../../../blocs/dashboard_bloc/dashboard_event.dart';
import '../../../blocs/dashboard_bloc/dashboard_state.dart';

class SummaryCards extends StatefulWidget {
  const SummaryCards({super.key});

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
    // إضافة حدث واحد فقط لأنه يقوم بجلب كل البيانات دفعة واحدة
    final bloc = context.read<DashboardBloc>();
    bloc.add(FetchDashboardData());
  }

  @override
  Widget build(BuildContext context) {
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
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SummaryCard(
                title: "Total Clients",
                amount: _formatAmount(totalClients),
                color: Colors.indigo,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SummaryCard(
                title: "Sessions This Month",
                amount: _formatAmount(sessionsThisMonth),
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: SummaryCard(
                title: "Total Revenue",
                amount: "\$12,340.00",
                color: Colors.green,
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

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
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
