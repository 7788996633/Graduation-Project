import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/issue_progress_reports/issue_progress_reports_bloc.dart';
import '../../../blocs/issue_progress_reports/issue_progress_reports_event.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/issue_progress_reports_list.dart';
import '../../widgets/refresh_button.dart';
import 'add_issue_progress_report.dart';

class ListIssueProgressReportsScreen extends StatefulWidget {
  const ListIssueProgressReportsScreen({super.key});

  @override
  State<ListIssueProgressReportsScreen> createState() =>
      _ListIssueProgressReportsScreenState();
}

class _ListIssueProgressReportsScreenState
    extends State<ListIssueProgressReportsScreen> {
  late IssueProgressReportBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<IssueProgressReportBloc>(context);
    bloc.add(GetAllIssueProgressReportsEvent());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Issue_Progress_Reports',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Issue Progress Report',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: bloc,
                child: const AddIssueProgressReportScreen(),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            IssueProgressReportList(bloc: bloc),

      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllIssueProgressReportsEvent());
        },
      ),
    );
  }
}
