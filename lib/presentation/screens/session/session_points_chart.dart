import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:graduation/blocs/issue_bloc/issues_bloc.dart';
import 'package:graduation/blocs/session_points_bloc/session_points_bloc.dart';

import '../../../blocs/case_type_percentages_bloc/case_type_percentages_bloc.dart';
import '../../../blocs/case_type_percentages_bloc/case_type_percentages_event.dart';
import '../../../blocs/case_type_percentages_bloc/case_type_percentages_state.dart';

class SessionPointsChart extends StatelessWidget {
  const SessionPointsChart({super.key, required this.issueId});
  final int issueId;
  @override
  Widget build(BuildContext context) {
    context.read<SessionPointsBloc>().add(
          GetAllPointByIssueId(
            issueId: issueId,
          ),
        );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<SessionPointsBloc, SessionPointsState>(
        builder: (context, state) {
          if (state is SessionPointsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SessionPointsFail) {
            return Center(child: Text('Error: ${state.errmsg}'));
          } else if (state is SessionPointsListLoaded) {
            final data = state.points;

            if (data.isEmpty) {
              return const Center(child: Text('No data found'));
            }

            final hasNonZero = data.any((item) => item.percentage > 0);

            final topThree = hasNonZero
                ? (data..sort((a, b) => b.percentage.compareTo(a.percentage)))
                    .where((e) => e.percentage > 0)
                    .take(3)
                    .toList()
                : [];

            final colors = [Colors.blue, Colors.orange, Colors.green];

            final sections = hasNonZero
                ? topThree.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final name =
                        (item.type.isNotEmpty) ? item.type[0].name : 'Unknown';

                    return PieChartSectionData(
                      color: colors[index % colors.length],
                      value: item.percentage,
                      title: '${item.percentage.toStringAsFixed(1)}%',
                      radius: 50,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    );
                  }).toList()
                : [
                    PieChartSectionData(
                      color: Colors.grey.shade300,
                      value: 100,
                      title: '0%',
                      radius: 50,
                      titleStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )
                  ];

            return LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Points Percentage',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: PieChart(
                        PieChartData(
                          sections: sections,
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (hasNonZero && topThree.isNotEmpty) ...[
                      const Text(
                        'Top 3 Lawyers:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: topThree.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          final name = (item.type.isNotEmpty)
                              ? item.type[0].name
                              : 'Unknown';

                          return LegendItem(
                            color: colors[index % colors.length],
                            text: name,
                          );
                        }).toList(),
                      ),
                    ]
                  ],
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

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
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
