import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../blocs/issue_requests_bloc/issue_requests_event.dart';
import '../../constant.dart';
import '../../data/models/issue_request_model.dart';
import '../screens/issue_request/issue_request_detials_screen.dart';
import 'custom_user_item.dart';

class AdminIssueRequestItem extends StatefulWidget {
  const AdminIssueRequestItem({
    super.key,
    required this.request,
    required this.bloc,
  });

  final IssueRequestModel request;
  final IssueRequestsBloc bloc;

  @override
  State<AdminIssueRequestItem> createState() => _AdminIssueRequestItemState();
}

class _AdminIssueRequestItemState extends State<AdminIssueRequestItem> {
  @override
  Widget build(BuildContext context) {
    return CustomUserItem(
      userModel: widget.request.userModel,
      subtitle: Text(widget.request.title),
      trailing: myRole == "admin"
          ? PopupMenuButton(
              onSelected: (value) {
                if (value == IssueRequestStatus.approved) {
                  print("Approved");
                } else if (value == IssueRequestStatus.rejected) {
                  print("Rejected");
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: IssueRequestStatus.approved,
                  child: Text("Approve"),
                ),
                PopupMenuItem(
                  value: IssueRequestStatus.rejected,
                  child: Text("Reject"),
                ),
              ],
            )
          : const SizedBox(),
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: widget.bloc,
              child: IssueRequestDetailsScreen(
                userModel: widget.request.userModel,
                issueRequest: widget.request,
              ),
            ),
          ),
        );
        (myRole == 'admin')
            ? widget.bloc.add(GetAllIssueRequestsEvent())
            : widget.bloc.add(GetMyIssueRequestsEvent());
      },
    );
  }
}
