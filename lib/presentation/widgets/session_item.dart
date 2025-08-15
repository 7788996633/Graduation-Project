import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/issue_progress_reports/issue_progress_reports_bloc.dart';

import '../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../blocs/sessions_bloc/sessions_event.dart';
import '../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../blocs/session_type_bloc/session_type_event.dart';

import '../../data/models/session_model.dart';
import '../../themes.dart';
import '../screens/session/session_details_screen.dart';

class SessionItem extends StatelessWidget {
  const SessionItem({super.key, required this.sessionModel});
  final SessionModel sessionModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionTypeBloc()
        ..add(
            GetSessionTypeByIdEvent(sessionTypeId: sessionModel.sessionTypeId)),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => SessionsBloc(),
                    ),
                    BlocProvider(
                      create: (context) => IssueProgressReportBloc(),
                    ),
                  ],
                  child: SessionDetailsScreen(
                    sessionModel: sessionModel,
                  ),
                ),
              ),
            );
          },
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<SessionsBloc>(context).add(
                DeleteSessionEvent(sessionId: sessionModel.sessionId),
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          title: Text(
            "Session #${sessionModel.sessionId}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
          ),
          subtitle: BlocBuilder<SessionTypeBloc, SessionTypeState>(
            builder: (context, state) {
              if (state is SessionTypeLoaded) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.category,
                          size: 18, color: AppColors.darkBlue),
                      const SizedBox(width: 6),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 14),
                          children: [
                            const TextSpan(
                              text: 'Session Type: ',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: state.session.type,
                              style: const TextStyle(
                                color: AppColors.darkBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is SessionTypeFail) {
                return const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Failed to load session type',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textGrey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
