import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 10),
              FlSpot(1, 12),
              FlSpot(2, 15),
              FlSpot(3, 13),
              FlSpot(4, 17),
              FlSpot(5, 25),
            ],
            isCurved: true,
            barWidth: 3,
            color: Colors.orange,
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: [
              FlSpot(0, 8),
              FlSpot(1, 9),
              FlSpot(2, 10),
              FlSpot(3, 12),
              FlSpot(4, 13),
              FlSpot(5, 15),
            ],
            isCurved: true,
            barWidth: 3,
            color: Colors.blue,
            dotData: FlDotData(show: false),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    (value.toInt() + 1).toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
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
      ),
    );
  }
}
