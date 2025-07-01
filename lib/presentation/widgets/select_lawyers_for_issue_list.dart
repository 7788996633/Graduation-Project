import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/presentation/widgets/lawyer_radio_item.dart';

import '../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../blocs/lawyer_bloc/lawyer_state.dart';
import '../../data/models/lawyer_model.dart';

class SelectLawyersForIssueList extends StatefulWidget {
  const SelectLawyersForIssueList(
      {super.key, required this.bloc, this.onLawyerSelected});
  final LawyerBloc bloc;
  final Function(int?)? onLawyerSelected;

  @override
  State<SelectLawyersForIssueList> createState() =>
      _SelectLawyersForIssueListState();
}

class _SelectLawyersForIssueListState extends State<SelectLawyersForIssueList> {
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
      child: BlocBuilder<LawyerBloc, LawyerState>(
        builder: (context, state) {
          if (state is LawyerLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LawyersListLoaded) {
            _allLawyers = state.lawyersList;
            return _buildLawyerList(_allLawyers);
          } else if (state is LawyerFail) {
            return Center(
              child: Text(
                'Error: ${state.errorMsg}',
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
