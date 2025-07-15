import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RevenueBarChart extends StatelessWidget {
  const RevenueBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> revenues = [
      12.5, 15.2, 10.8, 18.3, 22.0, 19.5, 25.7, 23.0, 20.1, 21.5, 24.3, 27.8,
    ];

    final List<double> expenses = [
      8.0, 10.0, 9.5, 11.0, 13.5, 14.0, 15.5, 17.0, 16.0, 18.0, 19.5, 20.0,
    ];

    final List<String> months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];

    return AspectRatio(
      aspectRatio: 1.3,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 35,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String label = rodIndex == 0 ? "Revenue" : "Expenses";
                return BarTooltipItem(
                  '${months[group.x]} \n$label: ${rod.toY.toStringAsFixed(1)} M',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    months[value.toInt()],
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()} M',
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(
            revenues.length,
                (index) => BarChartGroupData(
              x: index,
              barRods: [
                // Orange bar with a light orange gradient
                BarChartRodData(
                  toY: revenues[index],
                  width: 12,
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFB74D), // Light orange
                      Color(0xFFFFA726), // Medium orange
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: 35,
                    color: Colors.grey.shade200,
                  ),
                ),
                // Blue bar with color #8DAEF2 (light blue)
                BarChartRodData(
                  toY: expenses[index],
                  width: 12,
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF8DAEF2), // Light blue #8DAEF2
                      Color(0xFF527BDF), // Slightly darker blue
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: 35,
                    color: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
