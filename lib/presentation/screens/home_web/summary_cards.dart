import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/dashboard_bloc/dashboard_bloc.dart';
import '../../../blocs/dashboard_bloc/dashboard_state.dart';

class SummaryCards extends StatelessWidget {
  const SummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        String openCases = "0";
        String totalClients = "0";
        String sessionsThisMonth = "0";

        if (state is DashboardLoading) {
          openCases = "...";
          totalClients = "...";
          sessionsThisMonth = "...";
        } else if (state is DashboardSuccess) {
          openCases = state.openCases.toString();
          totalClients = state.totalClients.toString();
          sessionsThisMonth = state.sessionsThisMonth.toString();
        } else if (state is DashboardFailure) {
          openCases = "Error";
          totalClients = "Error";
          sessionsThisMonth = "Error";
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                child: SummaryCard(
                  title: "Open Cases",
                  amount: openCases,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SummaryCard(
                  title: "Total Clients",
                  amount: totalClients,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SummaryCard(
                  title: "Sessions This Month",
                  amount: sessionsThisMonth,
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
        );
      },
    );
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
