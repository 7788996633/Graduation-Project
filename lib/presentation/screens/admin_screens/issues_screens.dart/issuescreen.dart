import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../../blocs/invoices_bloc/invoices_bloc.dart';
import '../../../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../../../blocs/lawyer_in_issues_bloc/lawyer_in_issues_bloc.dart';
import '../../../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../../../constant.dart';
import '../../../../data/models/issues_model.dart';
import '../../../../data/models/user_profile_model.dart';
import '../../../widgets/add_lawyers_to_issue_sheet.dart';
import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/lawyers_in_issue_list.dart';
import '../../AttendDemand/all_attend_demand_screen.dart';
import '../../invoice_screen/add_invoice_screen.dart';
import '../../invoice_screen/invoice_by_issue_id_screen.dart';
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
    super.initState();
    BlocProvider.of<UserProfileBloc>(context).add(
      ShowUserProfileByIdEvent(userId: widget.issuesModel.user.id),
    );
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
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54)),
        subtitle: Text(value,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: kPrimaryDarkBlue)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomActionAppBar(title: 'Issue Details'),
      backgroundColor: const Color(0xFFF5F6FA),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                if (state is UserProfileLoadedSuccessfully) {
                  final user = state.userProfileModel;

                  return Column(
                    children: [
                      const SizedBox(height: 16),
                      buildProfileCard(user),
                      const SizedBox(height: 10),

                      // قائمة المحامين في القضية
                      BlocProvider(
                        create: (context) => LawyerInIssuesBloc(),
                        child: LawyersInIssueList(
                          issueId: widget.issuesModel.id,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // أزرار Sessions, Demands, Add Invoice, View Invoices في سطر واحد
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
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
                                child: const Text("Sessions", textAlign: TextAlign.center),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
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
                                child: const Text("Demands", textAlign: TextAlign.center),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
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
                                        create: (context) => InvoiceBloc(),
                                        child: AddInvoiceScreen(
                                          issueId: widget.issuesModel.id,
                                          userId: user.userId,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Add Invoice", textAlign: TextAlign.center),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
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
                                        create: (context) => InvoiceBloc(),
                                        child: ListInvoicesByIssueScreen(
                                          issueId: widget.issuesModel.id,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("View Invoices", textAlign: TextAlign.center),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // بقية تفاصيل القضية
                      buildSectionCard(
                          icon: Icons.title,
                          title: "Title",
                          value: widget.issuesModel.title),
                      buildSectionCard(
                          icon: Icons.numbers,
                          title: "Issue Number",
                          value: widget.issuesModel.issueNumber),
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
                    ],
                  );
                } else if (state is UserProfileFail) {
                  return Center(child: Text(state.errmsg));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),

          // زر ثابت أسفل المنتصف لإضافة محامين
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width * 0.5 - 90,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                foregroundColor: Colors.white,
                minimumSize: const Size(180, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              icon: const Icon(Icons.add, size: 20),
              label: const Text(
                "Add Lawyers",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => LawyerBloc()),
                      BlocProvider(create: (context) => IssuesBloc()),
                    ],
                    child: AddLawyersToIssueSheet(
                      issueId: widget.issuesModel.id,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
