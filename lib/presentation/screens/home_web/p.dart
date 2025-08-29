import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_event.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_state.dart';
import 'recent_activity.dart';

class IssueRequestsAcScreen extends StatefulWidget {
  const IssueRequestsAcScreen({super.key});

  @override
  State<IssueRequestsAcScreen> createState() => _IssueRequestsAcScreenState();
}

class _IssueRequestsAcScreenState extends State<IssueRequestsAcScreen> {
  late IssueRequestsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<IssueRequestsBloc>(context);
    bloc.add(GetAllIssueRequestsEvent()); // استدعاء لجلب البيانات
  }

  Future<void> _onRefresh() async {
    bloc.add(GetAllIssueRequestsEvent());
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Issue Requests')),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: BlocBuilder<IssueRequestsBloc, IssueRequestsState>(
          builder: (context, state) {
            if (state is IssueRequestsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is IssueRequestsFail) {
              return Center(child: Text(state.errmsg));
            } else if (state is IssueRequestsListLoaded) {
              return IssueRequestActivityList(
                requests: state.issueRequestsList, // تمرير القائمة هنا
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
