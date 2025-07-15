import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/documents_bloc/document_bloc.dart';
import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_event.dart';
import '../../../data/models/session_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../appiontment_session_screen/appointment_session_list_screen.dart';
import '../document/add_document_screen.dart';

class SessionDetailsScreen extends StatelessWidget {
  final SessionModel sessionModel;

  const SessionDetailsScreen({super.key, required this.sessionModel});

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => IssuesBloc()..add(IssueShowbyId(id: sessionModel.issueId))),
        BlocProvider(create: (_) => LawyerProfileBloc()..add(ShowLawyerProfileByIdEvent(lawyerId: sessionModel.lawyerId))),
        BlocProvider(create: (_) => SessionTypeBloc()..add(GetSessionTypeByIdEvent(sessionTypeId: sessionModel.sessionTypeId))),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F4F8),
        appBar: CustomActionAppBar(title: 'Session Details'),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<IssuesBloc, IssuesState>(
            builder: (context, issueState) {
              if (issueState is IssuesLoadedSuccessFully) {
                final issue = issueState.issue;

                return BlocBuilder<LawyerProfileBloc, LawyerProfileState>(
                  builder: (context, lawyerState) {
                    if (lawyerState is LawyerProfileLoadedSuccessfully) {
                      final lawyer = lawyerState.lawyerModel;

                      return BlocBuilder<SessionTypeBloc, SessionTypeState>(
                        builder: (context, sessionTypeState) {
                          if (sessionTypeState is SessionTypeLoaded) {
                            final sessionType = sessionTypeState.session;

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
                                              'Session #${sessionModel.sessionId}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                      _buildInfoRow(Icons.description, 'Outcome',
                                          sessionModel.outcome, 22, 16),
                                      const Divider(),
                                      _buildInfoRow(Icons.title, 'Issue Title', issue.title,
                                          22, 16),
                                      const Divider(),
                                      _buildInfoRow(Icons.person, 'Lawyer', lawyer.name,
                                          22, 16),
                                      const Divider(),
                                      _buildInfoRow(
                                        Icons.check_circle,
                                        'Is Attend',
                                        sessionModel.isAttend == 1 ? "Yes" : "No",
                                        22,
                                        16,
                                      ),
                                      const Divider(),
                                      _buildInfoRow(Icons.category, 'Session Type',
                                          sessionType.type, 22, 16),
                                      const SizedBox(height: 30),
                                      Row(
                                        children: [
                                          Expanded(child: _buildAddDocButton(context)),
                                          const SizedBox(width: 12),
                                          Expanded(child: _buildAppointmentsButton(context)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if (sessionTypeState is SessionTypeFail) {
                            return Center(child: Text("Failed to load session type: ${sessionTypeState.errMsg}"));
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                      );
                    } else if (lawyerState is LawyerProfileFail) {
                      return Center(child: Text("Failed to load lawyer: ${lawyerState.errmsg}"));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
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

  Widget _buildAddDocButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => DocumentBloc(),
              child: AddDocumentScreen(sessionId: sessionModel.sessionId),
            ),
          ),
        );
      },
      icon: const Icon(Icons.upload_file, size: 22),
      label: const Text('Add Document', style: TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
      ),
    );
  }

  Widget _buildAppointmentsButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AppointmentSessionListScreen(sessionId: sessionModel.sessionId),
          ),
        );
      },
      icon: const Icon(Icons.event_available, size: 22),
      label: const Text('Appointments', style: TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.darkBlue,
        side: BorderSide(color: AppColors.darkBlue, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
      ),
    );
  }
}
