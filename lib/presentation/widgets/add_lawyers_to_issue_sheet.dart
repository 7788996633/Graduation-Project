import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/issue_bloc/issues_bloc.dart';
import '../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../blocs/lawyer_bloc/lawyer_event.dart';
import 'select_lawyers_for_issue_list.dart';

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
    super.initState();
    bloc = BlocProvider.of<LawyerBloc>(context);
    bloc.add(
      GetAllLawyersEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: MediaQuery.sizeOf(context).height * 0.5,
      child: Column(
        children: [
          const Text(
            "Select Lawyers",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: SelectLawyersForIssueList(
              bloc: bloc,
              onLawyersSelected: (ids) {
                setState(
                  () {
                    selectedLawyersIds = ids;
                  },
                );
              },
            ),
          ),
          BlocConsumer<IssuesBloc, IssuesState>(
            listener: (context, state) {
              if (state is IssuesSuccess) {
                showDialog(
                  context: context,
                  barrierDismissible: false, // منع إغلاقه بالنقر خارج الصندوق
                  builder: (context) => AlertDialog(
                    content: Text(
                      state.successmsg,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );

                // إغلاق الرسالة بعد 2 ثانية و إغلاق الـ Bottom Sheet
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pop(); // إغلاق الـ AlertDialog
                  Navigator.of(context).pop(); // إغلاق الـ Bottom Sheet
                });
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
                onPressed: selectedLawyersIds.isEmpty
                    ? null
                    : () {
                  BlocProvider.of<IssuesBloc>(context).add(
                    AssignIsuueToLawyerEvent(
                      issueId: widget.issueId,
                      lawyerIds: selectedLawyersIds,
                    ),
                  );
                  print("===========================================");
                  print(selectedLawyersIds);
                },
                child: const Text("Add"),
              );
            },
          ),

        ],
      ),
    );
  }
}
