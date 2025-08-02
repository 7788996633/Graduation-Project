import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/issue_progress_reports/issue_progress_reports_bloc.dart';
import '../../../blocs/issue_progress_reports/issue_progress_reports_event.dart';
import '../../../blocs/issue_progress_reports/issue_progress_reports_state.dart';
import '../../../data/models/issue_progress_reports_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import 'update_issue_progress_reports_screen.dart';

class IssueProgressReportDetailsScreen extends StatefulWidget {
  final IssueProgressReportModel issueProgressReportModel;
  const IssueProgressReportDetailsScreen({super.key, required this.issueProgressReportModel});
  @override
  State<IssueProgressReportDetailsScreen> createState() => _IssueProgressReportDetailsScreenState();
}

class _IssueProgressReportDetailsScreenState extends State<IssueProgressReportDetailsScreen> {
  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: valueColor ?? Colors.black87,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<IssueProgressReportBloc>(context).add(
      GetIssueProgressReportByIdEvent(reportId: widget.issueProgressReportModel.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: CustomActionAppBar(
        title: 'Issue Progress Report Details',
      ),
      body: BlocBuilder<IssueProgressReportBloc, IssueProgressReportState>(
        builder: (context, state) {
          if (state is IssueProgressReportLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is IssueProgressReportLoaded) {
            final report = state.report;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 12,
                shadowColor: Colors.deepPurple.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.description_outlined,
                          size: 80,
                          color: AppColors.darkBlue,
                          shadows: [
                            Shadow(
                              color: Colors.blueAccent.shade200.withOpacity(0.6),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoRow('ID', report.id.toString()),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Report', report.report),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Pre-session Count', report.preSessionCount.toString()),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Session ID', report.sessionId.toString()),

                    ],
                  ),
                ),
              ),
            );
          } else if (state is IssueProgressReportFail) {
            return Center(child: Text('Error: ${state.errMsg}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: BlocBuilder<IssueProgressReportBloc, IssueProgressReportState>(
        builder: (context, state) {
          if (state is IssueProgressReportLoaded) {
            return FloatingActionButton.extended(
              onPressed: () async {
                final result = await Navigator.push<IssueProgressReportModel>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => IssueProgressReportBloc(),
                      child: UpdateIssueProgressScreen(issueProgress: state.report),
                    ),
                  ),
                );

                if (result != null) {
                  BlocProvider.of<IssueProgressReportBloc>(context).add(
                    GetIssueProgressReportByIdEvent(reportId: result.id),
                  );
                }
              },
              icon: const Icon(Icons.edit),
              label: const Text(
                'Edit',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppColors.darkBlue,
              elevation: 6,
              hoverElevation: 12,
              extendedPadding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
