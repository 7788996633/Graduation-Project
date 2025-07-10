import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../blocs/case_type_percentages_bloc/case_type_percentages_bloc.dart';
import '../../../blocs/case_type_percentages_bloc/case_type_percentages_event.dart';
import '../../../blocs/case_type_percentages_bloc/case_type_percentages_state.dart';



class CaseTypePercentagesScreen extends StatelessWidget {
  const CaseTypePercentagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ارسال حدث جلب البيانات عند بناء الشاشة
    context.read<CaseTypeBloc>().add(FetchCaseTypePercentages());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Case Type Percentages'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CaseTypeBloc, CaseTypeState>(
          builder: (context, state) {
            if (state is CaseTypeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CaseTypeFailure) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is CaseTypeSuccess) {
              final data = state.data;

              if (data.isEmpty) {
                return const Center(child: Text('No data found'));
              }

              // تجهيز بيانات الرسم البياني
              final sections = data.map((item) {
                final name = (item.type.isNotEmpty) ? item.type[0].name : 'Unknown';
                return PieChartSectionData(
                  color: _colorForName(name),
                  value: item.percentage,
                  title: '${item.percentage.toStringAsFixed(1)}%',
                  radius: 50,
                  titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                );
              }).toList();

              return Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: PieChart(
                      PieChartData(
                        sections: sections,
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: data.map((item) {
                      final name = (item.type.isNotEmpty) ? item.type[0].name : 'Unknown';
                      return LegendItem(
                        color: _colorForName(name),
                        text: name,
                      );
                    }).toList(),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  // دالة بسيطة لاختيار لون حسب اسم القضية
  Color _colorForName(String name) {
    switch (name.toLowerCase()) {
      case 'مدنية':
      case 'civil':
        return Colors.blue;
      case 'جزائية':
      case 'criminal':
        return Colors.red;
      case 'تجارية':
      case 'business':
        return Colors.orange;
      case 'عسكرية':
        return Colors.purple;
      default:
        return Colors.grey;
    }
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
        Container(width: 14, height: 14, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
