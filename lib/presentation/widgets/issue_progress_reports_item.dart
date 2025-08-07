import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/issue_progress_reports/issue_progress_reports_bloc.dart';

import '../../blocs/issue_progress_reports/issue_progress_reports_event.dart';
import '../../data/models/issue_progress_reports_model.dart';
import '../../themes.dart';
import '../screens/issue_progress_reports_screen/issue_progress_reports_detials_screen.dart';

class IssueProgressReportItem extends StatelessWidget {
  const IssueProgressReportItem({
    super.key,
    required this.issueProgressReportModel,
  });

  final IssueProgressReportModel issueProgressReportModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.grey.shade400,
            width: 2,
          ),
        ),
        shadowColor: AppColors.darkBlue.withOpacity(0.4),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => IssueProgressReportBloc(),
                  child: IssueProgressReportDetailsScreen(
                    issueProgressReportModel: issueProgressReportModel,
                  ),
                ),
              ),
            );
          },
          leading: Container(
            decoration: BoxDecoration(
              color: AppColors.darkBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                BlocProvider.of<IssueProgressReportBloc>(context).add(
                  DeleteIssueProgressReportEvent(
                    reportId: issueProgressReportModel.id,
                  ),
                );
              },
              icon: Icon(
                Icons.delete_forever,
                color: AppColors.darkBlue,
                size: 28,
              ),
              tooltip: 'Delete Report',
            ),
          ),
          title: Text(
            'Report #${issueProgressReportModel.id}',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.darkBlue,
              letterSpacing: 0.5,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                'Report: ${issueProgressReportModel.report}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.darkBlue.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Pre-session count: ${issueProgressReportModel.preSessionCount}',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.darkBlue.withOpacity(0.6),
                ),
              ),

            ],
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: AppColors.darkBlue.withOpacity(0.7),
            size: 32,
          ),
        ),
      ),
    );
  }
}
