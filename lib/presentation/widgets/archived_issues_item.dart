import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/archive_bloc/archive_bloc.dart';
import '../../blocs/archive_bloc/archive_event.dart';
import '../../blocs/issue_bloc/issues_bloc.dart';
import '../../data/models/archive_model.dart';
import '../../themes.dart';
import '../screens/archive_screen/archived_issues_details_screen.dart';

class ArchivedIssuesItem extends StatelessWidget {
  const ArchivedIssuesItem({super.key, required this.archiveModel});
  final ArchiveModel archiveModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IssuesBloc()..add(IssueShowbyId(id: archiveModel.issueId)),
      child: BlocBuilder<IssuesBloc, IssuesState>(
        builder: (context, state) {
          if (state is IssuesLoadedSuccessFully) {
            final issue = state.issue;

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
                          create: (_) => ArchiveBloc(),
                          child: ArchivedIssuesDetailsScreen(archiveModel: archiveModel),
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
                        BlocProvider.of<ArchiveBloc>(context).add(
                          DeleteArchiveEvent(archiveId: archiveModel.id),
                        );
                      },
                      icon: Icon(
                        Icons.delete_forever,
                        color: AppColors.darkBlue,
                        size: 28,
                      ),
                      tooltip: 'Delete Archive',
                    ),
                  ),
                  title: Text(
                    issue.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkBlue,
                      letterSpacing: 0.5,
                    ),
                  ),
                  subtitle: Text(
                    'Issue Number: ${issue.issueNumber}',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.darkBlue.withOpacity(0.6),
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColors.darkBlue.withOpacity(0.7),
                    size: 32,
                  ),
                ),
              ),
            );
          } else if (state is IssuesFail) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Failed to load issue: ${state.errmsg}', style: const TextStyle(color: Colors.red)),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
