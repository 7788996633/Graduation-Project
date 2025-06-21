import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled27/presentation/widgets/select_lawyer_for_session_list.dart';

import '../../blocs/lawyer_in_issues_bloc/lawyer_in_issues_bloc.dart';
import '../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../blocs/sessions_bloc/sessions_event.dart';
import '../../blocs/sessions_bloc/sessions_state.dart';

class AddLawyerToSessionSheet extends StatefulWidget {
  const AddLawyerToSessionSheet(
      {super.key, required this.issueId, required this.sessionTypeId});
  final int issueId;
  final int sessionTypeId;


  @override
  State<AddLawyerToSessionSheet> createState() =>
      _AddLawyerToSessionSheetState();
}

class _AddLawyerToSessionSheetState extends State<AddLawyerToSessionSheet> {
  int? selectedUserId;

  late LawyerInIssuesBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<LawyerInIssuesBloc>(context);
    bloc.add(
      GetAllLawyersInIssuesEvent(
        issueId: widget.issueId,
      ),
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
          SelectLawyerForSessionList(
            onLawyerSelected: (id) {
              setState(
                () {
                  selectedUserId = id;
                },
              );
            },
          ),
          BlocConsumer<SessionsBloc, SessionsState>(
            listener: (context, state) {
              if (state is SessionsSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.successmsg,
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is SessionsFail) {
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
                  BlocProvider.of<SessionsBloc>(context).add(
                    CreateSessionsEvent(
                      sessionTypeId: widget.sessionTypeId,
                      issueId: widget.issueId,
                      lawyerId: selectedUserId!,
                    ),
                  );
                },
                child: const Text(
                  "Create",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
