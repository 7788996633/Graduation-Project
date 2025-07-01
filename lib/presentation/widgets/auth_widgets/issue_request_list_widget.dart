import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../../data/models/issue_request_model.dart';
import '../admin_issue_request_item.dart';

class RequestListWidget extends StatelessWidget {
  final List<IssueRequestModel> requests;

  const RequestListWidget({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return const Center(
        child: Text("No issue requests found."),
      );
    }
    return BlocProvider(
      create: (context) => UserProfileBloc(),
      child: ListView.separated(
        itemCount: requests.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return AdminIssueRequestItem(
            bloc: BlocProvider.of<IssueRequestsBloc>(context),
            request: requests[index],
          );
        },
      ),
    );
  }
}
