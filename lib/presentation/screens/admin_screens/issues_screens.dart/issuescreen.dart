import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../../../blocs/lawyer_in_issues_bloc/lawyer_in_issues_bloc.dart';
import '../../../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../../../data/models/issues_model.dart';
import '../../../../data/models/user_profile_model.dart';
import '../../../widgets/add_lawyers_to_issue_sheet.dart';
import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/lawyers_in_issue_list.dart';
import '../../AttendDemand/all_attend_demand_screen.dart';
import '../../session/list_session_screen.dart';

class IssueScreen extends StatefulWidget {
  final IssuesModel issuesModel;
  const IssueScreen({super.key, required this.issuesModel});

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
  static const Color kPrimaryDarkBlue = Color(0xFF472A0C);

  @override
  void initState() {
    BlocProvider.of<UserProfileBloc>(context).add(
      ShowUserProfileByIdEvent(userId: widget.issuesModel.userId),
    );
    super.initState();
  }

  Widget buildProfileCard(UserProfileModel user) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.image),
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E3B55),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF5F7FA), Color(0xFFDCE4EC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: kPrimaryDarkBlue),
        title: Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black54)),
        subtitle: Text(value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kPrimaryDarkBlue)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomActionAppBar(title: 'Issue Details'),
      backgroundColor: const Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                if (state is UserProfileLoadedSuccessfully) {
                  return buildProfileCard(state.userProfileModel);
                } else if (state is UserProfileFail) {
                  return Text(state.errmsg);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(height: 10),
            BlocProvider(
              create: (context) => LawyerInIssuesBloc(),
              child: LawyersInIssueList(issueId: widget.issuesModel.id),
            ),
            buildSectionCard(
                icon: Icons.title,
                title: "Title",
                value: widget.issuesModel.title),
            buildSectionCard(
                icon: Icons.numbers,
                title: "Issue Number",
                value: widget.issuesModel.issueNumber),
            buildSectionCard(
                icon: Icons.category,
                title: "Category",
                value: widget.issuesModel.category),
            buildSectionCard(
                icon: Icons.title,
                title: "Court Name",
                value: widget.issuesModel.courtName),
            buildSectionCard(
                icon: Icons.payments,
                title: "Number of Payments",
                value: widget.issuesModel.numberOfPayments.toString()),
            buildSectionCard(
                icon: Icons.attach_money,
                title: "Total Cost",
                value: widget.issuesModel.totalCost.toString()),
            buildSectionCard(
                icon: Icons.info,
                title: "Status",
                value: widget.issuesModel.status),
            buildSectionCard(
                icon: Icons.priority_high,
                title: "Priority",
                value: widget.issuesModel.priority),
            buildSectionCard(
                icon: Icons.date_range,
                title: "Start Date",
                value: widget.issuesModel.startDate),
            buildSectionCard(
                icon: Icons.date_range,
                title: "Created At",
                value: widget.issuesModel.createdAt),
            buildSectionCard(
                icon: Icons.date_range,
                title: "Updated At",
                value: widget.issuesModel.updatedAt),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryDarkBlue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => LawyerBloc(),
                            ),
                            BlocProvider(
                              create: (context) => IssuesBloc(),
                            ),
                          ],
                          child: AddLawyersToIssueSheet(
                              issueId: widget.issuesModel.id),
                        ),
                      );
                    },
                    child: const Text("Add Lawyers"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryDarkBlue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => SessionsBloc(),
                            child: ListSessionsScreen(
                              issueId: widget.issuesModel.id,
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text("Sessions"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryDarkBlue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllAttendDemandScreen(
                            issueId: widget.issuesModel.id,
                          ),
                        ),
                      );
                    },
                    child: const Text("Demands"),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
