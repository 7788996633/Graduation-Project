import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/issue_requests_bloc/issue_requests_state.dart';

import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_event.dart';
import '../../../constant.dart';
import '../../../data/models/issue_request_model.dart';
import '../../../data/models/user_model.dart';
import '../../../themes.dart';
import '../../widgets/build_info_title.dart';
import 'update_issue_request_screen.dart';

class IssueRequestDetailsScreen extends StatefulWidget {
  final IssueRequestModel issueRequest;
  final UserModel userModel;
  const IssueRequestDetailsScreen(
      {super.key, required this.issueRequest, required this.userModel});

  @override
  State<IssueRequestDetailsScreen> createState() =>
      _IssueRequestDetailsScreenState();
}

class _IssueRequestDetailsScreenState extends State<IssueRequestDetailsScreen> {
  late IssueRequestsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<IssueRequestsBloc>();
    print(myRole);

    if (myRole == 'admin' && widget.issueRequest.status == 'pending') {
      bloc.add(
          StartIssueRequestReviewEvent(issueRequestId: widget.issueRequest.id));
      print(myRole);
    }
  }

  @override
  void dispose() {
    if (myRole == 'admin' && widget.issueRequest.status == 'pending') {
      bloc.add(
          EndIssueRequestReviewEvent(issueRequestId: widget.issueRequest.id));
    }
    super.dispose();
  }

  Widget buildProfileUI(IssueRequestModel request, BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: getCurrentTheme()['BackGorund'],
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.userModel.name,
                style: TextStyle(
                  color: getCurrentTheme()['BoldText'],
                ),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.userModel.profileModel.image,
                ),
              ),
              const SizedBox(height: 20),
              buildInfoTile(
                Icons.subject,
                "title",
                request.title,
              ),
              buildInfoTile(
                  Icons.description, "description", request.description),
              buildInfoTile(Icons.verified, "status", request.status),
              if (request.adminNote != null)
                buildInfoTile(
                  Icons.note_rounded,
                  "Admin note",
                  request.adminNote!,
                ),
              if (widget.issueRequest.status.toLowerCase() == 'pending')
                BlocConsumer<IssueRequestsBloc, IssueRequestsState>(
                  listener: (context, state) {
                    if (state is IssueRequestsSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Success: ${state.successmsg}"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else if (state is IssueRequestsFail) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Success: ${state.errmsg}"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        BlocProvider.of<IssueRequestsBloc>(context).add(
                          DeleteIssueRequestEvent(
                            issueRequestId: widget.issueRequest.id,
                          ),
                        );
                        if (state is IssueRequestsSuccess) {
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],
      appBar: AppBar(
        actions: [
          if (widget.issueRequest.status.toLowerCase() == 'pending' &&
              myRole == 'user')
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdateIssueRequestScreen(
                      issueRequest: widget.issueRequest,
                      bloc: bloc,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
                color: getCurrentTheme()['Icons'],
              ),
            ),
        ],
        backgroundColor: getCurrentTheme()['BackGorund'],
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.issueRequest.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: buildProfileUI(widget.issueRequest, context),
    );
  }
}
