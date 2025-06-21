import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_event.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_state.dart';
import '../../../constant.dart';

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

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<IssueRequestsBloc>(context);
    bloc.add(GetAllIssueRequestsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List Issue Requests',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Request',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => IssueRequestsBloc(),
                child: const AddIssueRequestScreen(),
              ),
            ),
          );
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
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is IssueRequestsListLoaded) {
                    return RequestListWidget(requests: state.issueRequestsList);
                  } else if (state is IssueRequestsLoadedSuccessfully) {
                    return RequestListWidget(
                      requests: [state.issueRequest],
                    );
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
          bloc.add(
            GetAllIssueRequestsEvent(),
          );
        },
      ),
    );
  }
}
