import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/issue_bloc/issues_bloc.dart';
import 'package:graduation/blocs/lawyer_bloc/lawyer_bloc.dart';
import 'package:graduation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:graduation/data/models/user_profile_model.dart';
import 'package:graduation/presentation/widgets/add_lawyers_to_issue_sheet.dart';

import '../../../../data/models/issues_model.dart';
import 'edit_issue_screen.dart';

class IssueScreen extends StatefulWidget {
  const IssueScreen({super.key, required this.issuesModel});
  final IssuesModel issuesModel;
  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
  @override
  void initState() {
    BlocProvider.of<UserProfileBloc>(context).add(
      ShowUserProfileByIdEvent(
        userId: widget.issuesModel.userId,
      ),
    );
    super.initState();
  }

  late UserProfileModel userProfileModel;
  final Color customColor = const Color(0xFF472A0C);
  final Color valueColor = const Color(0xFF0F6829);

  Widget buildInfoTile(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: customColor),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: TextStyle(color: customColor),
                  ),
                  TextSpan(
                    text: value,
                    style: TextStyle(color: valueColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileUI() {
    return Center(
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, state) {
                  if (state is UserProfileLoadedSuccessfully) {
                    userProfileModel = state.userProfileModel;
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(userProfileModel.image),
                        ),
                        Text(
                          userProfileModel.name,
                        ),
                      ],
                    );
                  } else if (state is UserProfileFail) {
                    return Text(state.errmsg);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Lawyer Certificate",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              buildInfoTile(Icons.title, "Title", widget.issuesModel.title),
              buildInfoTile(Icons.numbers, "Issue Number",
                  widget.issuesModel.issueNumber),
              buildInfoTile(
                  Icons.category, "Category", widget.issuesModel.category),
              buildInfoTile(
                  Icons.title, "Court Name", widget.issuesModel.courtName),
              buildInfoTile(Icons.numbers, "Number Of Payments",
                  widget.issuesModel.numberOfPayments.toString()),
              buildInfoTile(Icons.numbers, "total Cost",
                  widget.issuesModel.totalCost.toString()),
              // buildInfoTile(Icons.numbers, "Amount Paid", issue.amountPaid),
              // buildInfoTile(Icons.title, "Description", issue.description),
              buildInfoTile(
                  Icons.title, "Court Name", widget.issuesModel.courtName),
              buildInfoTile(Icons.title, "Status", widget.issuesModel.status),
              buildInfoTile(
                  Icons.numbers, "Priority", widget.issuesModel.priority),
              buildInfoTile(
                  Icons.date_range, "Start Date", widget.issuesModel.startDate),
              // buildInfoTile(Icons.date_range, "End Date", issue.endDate),
              buildInfoTile(
                  Icons.date_range, "Start Date", widget.issuesModel.createdAt),
              buildInfoTile(
                  Icons.date_range, "End Date", widget.issuesModel.updatedAt),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditIssueScreen(
                    issue: widget.issuesModel,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: customColor,
        title: const Text(
          "Issue Screen",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildProfileUI(),
            Builder(
              builder: (innerContext) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: innerContext,
                    builder: (context) => BlocProvider(
                      create: (context) => LawyerBloc(),
                      child: BlocProvider(
                        create: (context) => IssuesBloc(),
                        child: AddLawyersToIssueSheet(
                          issueId: widget.issuesModel.id,
                        ),
                      ),
                    ),
                  );
                },
                child: const Text("Add Lawyers"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
