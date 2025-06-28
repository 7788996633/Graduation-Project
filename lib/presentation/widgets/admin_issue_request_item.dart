import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/issue_requests_bloc/issue_requests_bloc.dart';
import 'package:graduation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:graduation/constant.dart';
import 'package:graduation/data/models/issue_request_model.dart';
import 'package:graduation/presentation/widgets/custom_user_item.dart';

import '../../blocs/issue_requests_bloc/issue_requests_event.dart';
import '../screens/issue_request/issue_request_detials_screen.dart';

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
  late final UserProfileBloc userProfileBloc;

  @override
  void initState() {
    super.initState();
    userProfileBloc = UserProfileBloc()
      ..add(ShowUserProfileByIdEvent(userId: widget.request.userId));
  }

  @override
  void dispose() {
    userProfileBloc.close(); // مهم نغلق البلوك لما نخلص
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: userProfileBloc,
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoadedSuccessfully) {
            return CustomUserItem(
              userProfileModel: state.userProfileModel,
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
                        userProfileModel: state.userProfileModel,
                        issueRequest: widget.request,
                      ),
                    ),
                  ),
                );
                widget.bloc.add(GetAllIssueRequestsEvent());
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
