import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../constant.dart';
import '../../../data/models/issue_request_model.dart';
import '../../widgets/build_custom_appbar_detials.dart';
import '../../widgets/edit_button.dart';
import '../../widgets/build_info_title.dart';
import 'update_issue_request_screen.dart';

class IssueRequestDetailsScreen extends StatelessWidget {
  final IssueRequestModel issueRequest;

  const IssueRequestDetailsScreen({super.key, required this.issueRequest});
  Widget buildProfileUI(IssueRequestModel request, BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
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
              const SizedBox(height: 20),
              buildInfoTile(
                Icons.subject,
                "title",
                request.title,
              ),
              buildInfoTile(
                  Icons.description, "description", request.description),
              buildInfoTile(Icons.verified, "status", request.status),
              const SizedBox(height: 30),
              EditButton(
                destinationScreen: BlocProvider(
                  create: (context) => IssueRequestsBloc(),
                  child: UpdateIssueRequestScreen(
                    issueRequest: request,
                  ),
                ),
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
      backgroundColor: AppColors.scaffold,
      appBar: buildCustomAppBar("Issue Request"),
      body: buildProfileUI(issueRequest, context),
    );
  }
}
