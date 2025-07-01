import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TrafficPieChart extends StatelessWidget {
  const TrafficPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Pie Chart
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Colors.blue,
                  value: 40,
                  title: '40%',
                  radius: 50,
                  titleStyle: const TextStyle(color: Colors.white),
                ),
                PieChartSectionData(
                  color: Colors.red,
                  value: 35,
                  title: '35%',
                  radius: 50,
                  titleStyle: const TextStyle(color: Colors.white),
                ),
                PieChartSectionData(
                  color: Colors.orange,
                  value: 25,
                  title: '25%',
                  radius: 50,
                  titleStyle: const TextStyle(color: Colors.white),
                ),
              ],
              sectionsSpace: 2,
              centerSpaceRadius: 30,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Legend
        Wrap(
          spacing: 20,
          children: const [
            LegendItem(color: Colors.blue, text: 'Civil Cases'),
            LegendItem(color: Colors.red, text: 'Criminal Cases'),
            LegendItem(color: Colors.orange, text: 'Business Cases'),
          ],
        ),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}
