import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../blocs/lawyer_bloc/lawyer_event.dart';
import '../../blocs/lawyer_bloc/lawyer_state.dart';
import '../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';

import '../../data/models/lawyer_model.dart';
import 'lawyer_item.dart';

class LawyerList extends StatefulWidget {
  final Function(int)? onLawyerSelected;

  const LawyerList({super.key, this.onLawyerSelected});

  @override
  State<LawyerList> createState() => _LawyerListState();
}

class _LawyerListState extends State<LawyerList> {
  List<LawyerModel> lawyersList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LawyerBloc>(context).add(GetAllLawyersEvent());
  }

  Widget buildLawyerList() {
    return ListView.builder(
      itemCount: lawyersList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final lawyer = lawyersList[index];
        return BlocProvider(
          create: (context) => LawyerProfileBloc(),
          child: LawyerItem(lawyerModel: lawyer),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LawyerBloc, LawyerState>(
      listener: (context, state) {
        if (state is LawyerSuccess) {
          BlocProvider.of<LawyerBloc>(context).add(GetAllLawyersEvent());
        } else if (state is LawyerFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMsg, style: const TextStyle(fontSize: 16)),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LawyerBloc, LawyerState>(
        builder: (context, state) {
          if (state is LawyersListLoaded) {
            lawyersList = state.lawyersList;
            return lawyersList.isEmpty
                ? const Center(child: Text('There are no lawyers'))
                : buildLawyerList();
          } else if (state is LawyerFail) {
            return Column(
              children: [
                const Text("There is an error:", style: TextStyle(fontSize: 30)),
                Text(state.errorMsg, style: const TextStyle(fontSize: 30)),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
