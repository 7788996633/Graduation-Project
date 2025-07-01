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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // دائمًا 2 كارد في السطر
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
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

              // تقدر تعدل الـ aspectRatio حسب العرض عشان الكارد يطلع مرتب
              if (width >= 600) {
                aspectRatio = 2.0;
              } else {
                aspectRatio = 1.5;
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
