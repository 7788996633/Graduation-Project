import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/issue_bloc/issues_bloc.dart';
import 'package:graduation/blocs/lawyer_bloc/lawyer_bloc.dart';
import 'package:graduation/blocs/lawyer_bloc/lawyer_event.dart';
import 'package:graduation/presentation/widgets/select_lawyers_for_issue_list.dart';

class AddLawyersToIssueSheet extends StatefulWidget {
  const AddLawyersToIssueSheet({super.key, required this.issueId});
  final int issueId;
  @override
  State<AddLawyersToIssueSheet> createState() => _AddLawyersToIssueSheetState();
}

class _AddLawyersToIssueSheetState extends State<AddLawyersToIssueSheet> {
  List<int> selectedLawyersIds = [];

  late LawyerBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<LawyerBloc>(context);
    bloc.add(
      GetAllLawyersEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: MediaQuery.sizeOf(context).height * 0.5,
      child: Column(
        children: [
          const Text(
            "Select Lawyer",
          ),
          SelectLawyersForIssueList(
            bloc: bloc,
            onLawyerSelected: (id) {
              selectedLawyersIds.add(id!);
              setState(
                () {},
              );
            },
          ),
          BlocConsumer<IssuesBloc, IssuesState>(
            listener: (context, state) {
              if (state is IssuesSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.successmsg,
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is IssuesFail) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errmsg,
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<IssuesBloc>(context).add(
                    AssignIsuueToLawyerEvent(
                      issueId: widget.issueId,
                      lawyerIds: selectedLawyersIds,
                    ),
                  );
                },
                child: const Text(
                  "Add",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
