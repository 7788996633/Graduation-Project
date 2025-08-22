import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../data/models/archive_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class ArchivedIssuesDetailsScreen extends StatelessWidget {
  final ArchiveModel archiveModel;

  const ArchivedIssuesDetailsScreen({super.key, required this.archiveModel});

  Widget _buildInfoRow(
      IconData icon, String label, String value, double iconSize, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.darkBlue, size: iconSize),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(text: '$label: ', style: const TextStyle(color: Colors.black87)),
                  TextSpan(text: value, style: const TextStyle(color: AppColors.darkBlue)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IssuesBloc()..add(IssueShowbyId(id: archiveModel.issueId)),
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F4F8),
        appBar: CustomActionAppBar(title: 'Archived Issue Details'),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<IssuesBloc, IssuesState>(
            builder: (context, issueState) {
              if (issueState is IssuesLoadedSuccessFully) {
                final issue = issueState.issue;

                return SingleChildScrollView(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 12,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Icon(Icons.gavel_rounded,
                                    size: 44, color: AppColors.darkBlue),
                                const SizedBox(height: 10),
                                Text(
                                  'Issue #${archiveModel.issueId}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          _buildInfoRow(Icons.title, 'Title', issue.title, 22, 16),
                          const Divider(),
                          _buildInfoRow(Icons.confirmation_number, 'Issue Number', issue.issueNumber, 22, 16),
                          const Divider(),
                      //    _buildInfoRow(Icons.category, 'Category', issue.category, 22, 16),
                          const Divider(),
                          _buildInfoRow(Icons.person, 'Opponent Name', issue.opponentName, 22, 16),
                          const Divider(),
                          _buildInfoRow(Icons.account_balance, 'Court Name', issue.courtName, 22, 16),
                          const Divider(),
                          _buildInfoRow(Icons.payments, 'Payments Count', issue.numberOfPayments.toString(), 22, 16),
                          const Divider(),
                          _buildInfoRow(Icons.money, 'Total Cost', issue.totalCost, 22, 16),
                          const Divider(),
                          _buildInfoRow(Icons.attach_money, 'Amount Paid', issue.amountPaid, 22, 16),
                          const Divider(),
                          _buildInfoRow(Icons.info, 'Status', issue.status, 22, 16),
                          const Divider(),
                          _buildInfoRow(Icons.priority_high, 'Priority', issue.priority, 22, 16),
                          const Divider(),
                          _buildInfoRow(Icons.date_range, 'Start Date', issue.startDate, 22, 16),
                          const Divider(),
                          _buildInfoRow(Icons.date_range_outlined, 'End Date', issue.endDate, 22, 16),
                          const Divider(),
                          _buildInfoRow(Icons.calendar_today, 'Created At', issue.createdAt, 22, 16),
                          const Divider(),
                          _buildInfoRow(Icons.update, 'Updated At', issue.updatedAt, 22, 16),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (issueState is IssuesFail) {
                return Center(child: Text("Failed to load issue: ${issueState.errmsg}"));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
