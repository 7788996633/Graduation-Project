import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../blocs/lawyer_bloc/lawyer_state.dart';
import '../../data/models/lawyer_model.dart';
import 'all_lawyers_list_item.dart';

class AllLawyersList extends StatefulWidget {
  const AllLawyersList({super.key, required this.bloc});
  final LawyerBloc bloc;
  @override
  State<AllLawyersList> createState() => _AllLawyersListState();
}

class _AllLawyersListState extends State<AllLawyersList> {
  List<LawyerModel> _allLawyers = [];

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
        return AllLawyersListItem(
          lawyer: lawyers[index],
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
            return const Center(child: Text('No data yet.'));
          }
        },
      ),
    );
  }
}
