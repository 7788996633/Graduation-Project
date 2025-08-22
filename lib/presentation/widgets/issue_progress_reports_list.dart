import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/issue_progress_reports/issue_progress_reports_bloc.dart';
import '../../blocs/issue_progress_reports/issue_progress_reports_event.dart';
import '../../blocs/issue_progress_reports/issue_progress_reports_state.dart';

import '../../data/models/issue_progress_reports_model.dart';

import 'issue_progress_reports_item.dart';

class IssueProgressReportList extends StatefulWidget {
  const IssueProgressReportList({super.key, required this.bloc});
  final IssueProgressReportBloc bloc;

  @override
  State<IssueProgressReportList> createState() => _IssueProgressReportListState();
}

class _IssueProgressReportListState extends State<IssueProgressReportList> {
  List<IssueProgressReportModel> reportList = [];

  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllIssueProgressReportsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IssueProgressReportBloc, IssueProgressReportState>(
      listener: (context, state) {
        if (state is IssueProgressReportSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllIssueProgressReportsEvent());
        } else if (state is IssueProgressReportFail) {
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
      child: BlocBuilder<IssueProgressReportBloc, IssueProgressReportState>(
        builder: (context, state) {
          if (state is IssueProgressReportListLoaded) {
            reportList = state.list;
            if (reportList.isEmpty) {
              return const Center(child: Text('There are no issue progress reports'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: reportList.length,
                itemBuilder: (context, index) {
                  return IssueProgressReportItem(issueProgressReportModel: reportList[index]);
                },
              ),
            );
          } else if (state is IssueProgressReportFail) {
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
