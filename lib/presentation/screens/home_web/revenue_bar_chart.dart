import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/dash_bloc/dash_bloc.dart';
import '../../../blocs/dash_bloc/dash_state.dart';

class RevenueBarChart extends StatelessWidget {
  const RevenueBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashBloc, DashState>(
      builder: (context, state) {
        if (state is DashLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DashFail) {
          return Center(child: Text(state.errMsg));
        } else if (state is DashSuccess) {
          final months = state.monthlyData.map((e) => e.month).toList();
          final revenues = state.monthlyData.map((e) => e.totalRevenue).toList();
          final expenses = state.monthlyData.map((e) => e.totalCost).toList();

          return AspectRatio(
            aspectRatio: 1.3,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: (revenues + expenses).reduce((a, b) => a > b ? a : b) * 1.2,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String label = rodIndex == 0 ? "Revenue" : "Expenses";
                      return BarTooltipItem(
                        '${months[group.x]} \n$label: ${rod.toY.toStringAsFixed(1)}',
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
                          '${value.toInt()}',
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(
                  revenues.length,
                      (index) => BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: revenues[index],
                        width: 12,
                        borderRadius: BorderRadius.circular(4),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFB74D),
                            Color(0xFFFFA726),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: (revenues + expenses).reduce((a, b) => a > b ? a : b) * 1.2,
                          color: Colors.grey.shade200,
                        ),
                      ),
                      BarChartRodData(
                        toY: expenses[index],
                        width: 12,
                        borderRadius: BorderRadius.circular(4),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF8DAEF2),
                            Color(0xFF527BDF),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: (revenues + expenses).reduce((a, b) => a > b ? a : b) * 1.2,
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
