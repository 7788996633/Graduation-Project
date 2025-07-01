import 'package:flutter/material.dart';

class SummaryCards extends StatelessWidget {
  const SummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    print("Building SummaryCards...");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: const [
          Expanded(
            child: SummaryCard(
              title: "Open Cases",
              amount: "25",
              color: Colors.red,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: SummaryCard(
              title: "Total Clients",
              amount: "132",
              color: Colors.indigo,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: SummaryCard(
              title: "Sessions This Month",
              amount: "18",
              color: Colors.orange,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: SummaryCard(
              title: "Total Revenue",
              amount: "\$12,340.00",
              color: Colors.green,
            ),
          ),
        ],
      ),
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
        boxShadow: [
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
