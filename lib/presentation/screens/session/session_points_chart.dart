import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:graduation/responsive.dart';
import 'package:graduation/themes.dart';

import '../../../blocs/session_points_bloc/session_points_bloc.dart';

class SessionPointsChart extends StatelessWidget {
  const SessionPointsChart({super.key, required this.issueId});
  final int issueId;

  @override
  Widget build(BuildContext context) {
    context.read<SessionPointsBloc>().add(
          GetAllPointByIssueId(issueId: issueId),
        );

    return Container(
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

            // Pie sections
            final sections = hasNonZero
                ? topThree.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;

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
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Points Percentage',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: getCurrentTheme()['NormalText']),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 40),
                        height: constraints.maxHeight * 0.4,
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
                        Text(
                          'Top 3 Lawyers:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: getCurrentTheme()['NormalText'],
                          ),
                        ),
                        Column(
                          children: topThree.asMap().entries.map((entry) {
                            final index = entry.key;
                            final item = entry.value;

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: LegendItem(
                                color: colors[index % colors.length],
                                text:
                                    "${item.lawyerName} • Points: ${item.sessionPoints} • Amount: ${item.amount}",
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
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
          width: s14,
          height: s14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: s8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: s14,
              color: getCurrentTheme()['NormalText'],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
