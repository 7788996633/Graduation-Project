import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/responsive.dart';

import '../../blocs/delegations_bloc/delegations_bloc.dart';
import '../../blocs/delegations_bloc/delegations_event.dart';
import '../../blocs/delegations_bloc/delegations_state.dart';
import '../../data/models/delegations_model.dart';
import 'delegation_item.dart';

class DelegationList extends StatefulWidget {
  const DelegationList({super.key, required this.sessionId});
  final int sessionId;
  @override
  State<DelegationList> createState() => _DelegationListState();
}

class _DelegationListState extends State<DelegationList> {
  @override
  void initState() {
    BlocProvider.of<DelegationBloc>(context)
        .add(GetAllDelegationsBySessionEvent(
      sessionId: widget.sessionId,
    ));
    super.initState();
  }

  List<DelegationModel> delegationList = [];

  Widget buildDelegationListView() {
    return Container(
      padding: EdgeInsets.all(s12),
      child: ListView.builder(
        itemCount: delegationList.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) => DelegationItem(
          delegation: delegationList[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DelegationBloc, DelegationState>(
      listener: (context, state) {
        if (state is DelegationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          BlocProvider.of<DelegationBloc>(context)
              .add(GetAllDelegationsEvent());
        } else if (state is DelegationFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<DelegationBloc, DelegationState>(
        builder: (context, state) {
          if (state is DelegationListLoaded) {
            delegationList = state.list;
            return delegationList.isEmpty
                ? const Text('There are no delegations')
                : buildDelegationListView();
          } else if (state is DelegationFail) {
            return Column(
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.errMsg,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
