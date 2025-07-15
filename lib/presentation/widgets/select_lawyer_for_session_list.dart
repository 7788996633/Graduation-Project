import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/lawyer_in_issues_bloc/lawyer_in_issues_bloc.dart';
import '../../data/models/lawyer_model.dart';
import 'lawyer_radio_item.dart';

class SelectLawyerForSessionList extends StatefulWidget {
  const SelectLawyerForSessionList({super.key, this.onLawyerSelected});
  final Function(int?)? onLawyerSelected;

  @override
  State<SelectLawyerForSessionList> createState() =>
      _SelectLawyerForSessionListState();
}

class _SelectLawyerForSessionListState
    extends State<SelectLawyerForSessionList> {
  List<LawyerModel> _allLawyers = [];
  int? selectedLawyerId;

  Widget _buildLawyerList(List<LawyerModel> lawyers) {
    if (lawyers.isEmpty) {
      return const Center(
        child: Text("No lawyers found."),
      );
    }
    return ListView.separated(
      itemCount: lawyers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return LawyerRadioItem(
          lawyerModel: lawyers[index],
          onChanged: (value) {
            setState(() {
              selectedLawyerId = value;
            });
            widget.onLawyerSelected?.call(value);
          },
          groupValue: selectedLawyerId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<LawyerInIssuesBloc, LawyerInIssuesState>(
        builder: (context, state) {
          if (state is LawyerInIssuesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LawyerInIssuesListLoadedSuccessfully) {
            _allLawyers = state.lawyerInissues;
            return _buildLawyerList(_allLawyers);
          } else if (state is LawyerInIssuesFail) {
            return Center(
              child: Text(
                'Error: ${state.errmsg}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'No data yet.',
              ),
            );
          }
        },
      ),
    );
  }
}
