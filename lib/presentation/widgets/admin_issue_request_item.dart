import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../data/models/issue_request_model.dart';
import '../screens/issue_request/issue_request_detials_screen.dart';
import '../widgets/custom_user_item.dart';

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
  void initState() {
    super.initState();
    BlocProvider.of<UserProfileBloc>(context).add(
      ShowUserProfileByIdEvent(userId: widget.request.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileBloc()
        ..add(
          ShowUserProfileByIdEvent(userId: widget.request.userId),
        ),
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoadedSuccessfully) {
            return CustomUserItem(
              userProfileModel: state.userProfileModel,
              subtitle: Text(widget.request.title),
              trailing: PopupMenuButton(
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
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: widget.bloc,
                      child: IssueRequestDetailsScreen(
                        userProfileModel: state.userProfileModel,
                        issueRequest: widget.request,
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is UserProfileFail) {
            return Text(state.errmsg);
          } else {
            return const Text("Loading...");
          }
        },
      ),
    );
  }
}
