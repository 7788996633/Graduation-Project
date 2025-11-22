import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/constant.dart';

import '../../blocs/issue_progress_reports/issue_progress_reports_bloc.dart';
import '../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../blocs/sessions_bloc/sessions_event.dart';
import '../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../blocs/session_type_bloc/session_type_event.dart';

import '../../data/models/session_model.dart';
import '../../responsive.dart';
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
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: s10,
            colors: isLight.value
                ? [AppColors.darkBlue, AppColors.softGray, AppColors.white]
                : [Colors.black, AppColors.softGray, AppColors.white],
          ),
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
          leading: myRole == 'admin'
              ? IconButton(
                  onPressed: () {
                    BlocProvider.of<SessionsBloc>(context).add(
                      DeleteSessionEvent(sessionId: sessionModel.sessionId),
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              : SizedBox(),
          subtitle: BlocBuilder<SessionTypeBloc, SessionTypeState>(
            builder: (context, state) {
              if (state is SessionTypeLoaded) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.category,
                        size: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 14),
                          children: [
                            TextSpan(
                              text: state.session.type,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: s18),
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
          title: Text(
            DateFormat('d-M-yyyy').format(sessionModel.createdAt!),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: s18),
          ),
        ),
      ),
    );
  }
}
