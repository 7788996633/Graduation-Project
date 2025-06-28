import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/data/models/issue_request_model.dart';

import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_event.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_state.dart';
import '../../../../themes.dart';

import '../../widgets/auth_widgets/issue_request_list_widget.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/refresh_button.dart';
import 'add_issue_request.dart';

class ListIssueRequestsScreen extends StatefulWidget {
  const ListIssueRequestsScreen({super.key});

  @override
  State<ListIssueRequestsScreen> createState() =>
      _ListIssueRequestsScreenState();
}

class _ListIssueRequestsScreenState extends State<ListIssueRequestsScreen> {
  late IssueRequestsBloc bloc;
  bool _isInit = true; // حتى ما يعيد جلب البيانات كل مرة

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      bloc = BlocProvider.of<IssueRequestsBloc>(context);
      bloc.add(GetAllIssueRequestsEvent());
      _isInit = false;
    }
  }

  List<IssueRequestModel> issueRequestsList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List Issue Requests',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Request',
        onActionPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<IssueRequestsBloc>(),
                child: const AddIssueRequestScreen(),
              ),
            ),
          );
          bloc.add(GetAllIssueRequestsEvent());
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<IssueRequestsBloc, IssueRequestsState>(
                builder: (context, state) {
                  if (state is IssueRequestsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is IssueRequestsListLoaded) {
                    issueRequestsList = state.issueRequestsList;
                    return issueRequestsList.isEmpty
                        ? const Center(child: Text('There Is No data '))
                        : RequestListWidget(requests: issueRequestsList);
                  } else if (state is IssueRequestsSuccess) {
                    return issueRequestsList.isEmpty
                        ? const Center(child: Text('There Is No data '))
                        : RequestListWidget(requests: issueRequestsList);
                  } else if (state is IssueRequestsFail) {
                    return Center(
                      child: Text(
                        'Error: ${state.errmsg}',
                        style: const TextStyle(color: AppColors.danger),
                      ),
                    );
                  } else {
                    return const Center(child: Text('No data yet.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllIssueRequestsEvent());
        },
      ),
    );
  }
}
