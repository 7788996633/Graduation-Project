import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/lawyer_in_issues_bloc/lawyer_in_issues_bloc.dart';
import '../../data/models/lawyer_model.dart';
import 'custom_lawyer_item.dart';

class LawyersInIssueList extends StatefulWidget {
  const LawyersInIssueList({
    super.key,
    required this.issueId,
  });

  final int issueId;

  @override
  State<LawyersInIssueList> createState() => _LawyersInIssueListState();
}

class _LawyersInIssueListState extends State<LawyersInIssueList> {
  List<LawyerModel> _allLawyers = [];
  List<int> selectedLawyerIds = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LawyerInIssuesBloc>(context).add(
      GetAllLawyersInIssuesEvent(issueId: widget.issueId),
    );
  }

  Widget _buildLawyerList(
      List<LawyerModel> lawyers,
      double childAspectRatio,
      ) {
    if (lawyers.isEmpty) {
      return const Center(
        child: Text("No lawyers found."),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lawyers.length,
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250, // أقصى عرض للكارد الواحد
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        return CustomLawyerItem(
          lawyer: lawyers[index],
          isSelected: selectedLawyerIds.contains(lawyers[index].id),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LawyerInIssuesBloc, LawyerInIssuesState>(
      builder: (context, state) {
        if (state is LawyerInIssuesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LawyerInIssuesListLoadedSuccessfully) {
          _allLawyers = state.lawyerInissues;
          selectedLawyerIds = _allLawyers.map((lawyer) => lawyer.id).toList();

          return LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;
              double aspectRatio;

              // ضبط نسبة العرض إلى الارتفاع بناءً على حجم الشاشة
              if (kIsWeb) {
                if (width >= 1400) {
                  aspectRatio = 2.0;   // شاشات كبيرة جدًا (مثلاً دقة 4K أو شاشات كبيرة)
                } else if (width >= 1200) {
                  aspectRatio = 1.9;   // شاشات كبيرة (Desktop كبير)
                } else if (width >= 1000) {
                  aspectRatio = 1.7;   // شاشات متوسطة إلى كبيرة
                } else if (width >= 900) {
                  aspectRatio = 1.5;   // شاشات متوسطة (أقل من 1000 بيكسل)
                } else {
                  aspectRatio = 1.3;   // شاشات ويب صغيرة (مثل أجهزة التابلت الكبيرة أو النوافذ الصغيرة)
                }
              } else {
                if (width >= 600) {
                  aspectRatio = 1.6;   // موبايل كبير / تابلت
                } else {
                  aspectRatio = 1.4;   // موبايل صغير
                }
              }

              return _buildLawyerList(_allLawyers, aspectRatio);
            },
          );
        } else if (state is LawyerInIssuesFail) {
          return Center(
            child: Text(
              'Error: ${state.errmsg}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: Text('No data yet.'));
        }
      },
    );
  }
}
