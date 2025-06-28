import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled27/presentation/widgets/select_lawyer_for_session_list.dart';
import '../../blocs/lawyer_in_issues_bloc/lawyer_in_issues_bloc.dart';
import '../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../blocs/sessions_bloc/sessions_event.dart';
import '../../blocs/sessions_bloc/sessions_state.dart';
import '../screens/session/attend_radio.dart';


class AddLawyerToSessionSheet extends StatefulWidget {
  const AddLawyerToSessionSheet({
    super.key,
    required this.issueId,
    required this.sessionTypeId,
  });

  final int issueId;
  final int sessionTypeId;

  @override
  State<AddLawyerToSessionSheet> createState() =>
      _AddLawyerToSessionSheetState();
}

class _AddLawyerToSessionSheetState extends State<AddLawyerToSessionSheet> {
  int? selectedUserId;
  AttendStatus? selectedAttendStatus;

  int? get isAttend {
    if (selectedAttendStatus == AttendStatus.attend) return 1;
    if (selectedAttendStatus == AttendStatus.absent) return 0;
    return null;
  }

  late LawyerInIssuesBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<LawyerInIssuesBloc>(context);
    bloc.add(GetAllLawyersInIssuesEvent(issueId: widget.issueId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.sizeOf(context).height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Select Lawyer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          // قائمة المحامين
          SelectLawyerForSessionList(
            onLawyerSelected: (id) {
              setState(() => selectedUserId = id);
            },
          ),

          const SizedBox(height: 16),


          AttendRadio(
            selectedStatus: selectedAttendStatus,
            onChanged: (status) {
              setState(() => selectedAttendStatus = status);
            },
          ),

          const SizedBox(height: 16),


          BlocConsumer<SessionsBloc, SessionsState>(
            listener: (context, state) {
              if (state is SessionsSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.successmsg),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
              } else if (state is SessionsFail) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errmsg),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (selectedUserId == null || isAttend == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select a lawyer and attend status."),
                      ),
                    );
                    return;
                  }

                  BlocProvider.of<SessionsBloc>(context).add(
                    CreateSessionsEvent(
                      sessionTypeId: widget.sessionTypeId,
                      issueId: widget.issueId,
                      lawyerId: selectedUserId!,
                      isAttend: isAttend!,
                    ),
                  );
                },
                child: const Text("Create"),
              );
            },
          ),
        ],
      ),
    );
  }
}
