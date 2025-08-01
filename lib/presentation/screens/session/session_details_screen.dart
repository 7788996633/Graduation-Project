import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/documents_bloc/document_bloc.dart';
import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../../blocs/session_points_bloc/session_points_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_event.dart';
import '../../../data/models/session_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../appiontment_session_screen/appointment_session_list_screen.dart';
import '../document/add_document_screen.dart';

class SessionDetailsScreen extends StatefulWidget {
  final SessionModel sessionModel;

  const SessionDetailsScreen({super.key, required this.sessionModel});

  @override
  State<SessionDetailsScreen> createState() => _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends State<SessionDetailsScreen> {
  Widget _buildInfoRow(IconData icon, String label, String value,
      double iconSize, double fontSize) {
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
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(color: Colors.black87)),
                  TextSpan(
                      text: value,
                      style: const TextStyle(color: AppColors.darkBlue)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController noteController = TextEditingController();
  TextEditingController pointsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void showPointsEvaluate() {
      showModalBottomSheet(
        context: context,
        builder: (context) => BlocProvider(
          create: (context) => SessionPointsBloc(),
          child: Column(
            children: [
              AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                  ),
                ),
                title: Text("Evaluate this session"),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: noteController,
                      decoration: InputDecoration(
                        hintText: "Add your note",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: pointsController,
                      decoration: InputDecoration(
                        hintText: "Add points",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child:
                          BlocConsumer<SessionPointsBloc, SessionPointsState>(
                        listener: (context, state) async {
                          if (state is SessionPointsSuccess) {
                            Navigator.pop(context);
                            await Future.delayed(
                              Duration(
                                milliseconds: 500,
                              ),
                            );
                            noteController.clear();
                            pointsController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Success: ${state.successmsg}"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else if (state is SessionPointsFail) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Failed: ${state.errmsg}"),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<SessionPointsBloc>(context).add(
                                EvaluateLawyerPoints(
                                  sessionId: widget.sessionModel.sessionId,
                                  lawyerId: widget.sessionModel.lawyerId,
                                  points: int.parse(pointsController.text),
                                  notes: noteController.text,
                                ),
                              );
                            },
                            child: Text(
                              "Save",
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => IssuesBloc()
              ..add(IssueShowbyId(id: widget.sessionModel.issueId))),
        BlocProvider(
            create: (_) => LawyerProfileBloc()
              ..add(ShowLawyerProfileByIdEvent(
                  lawyerId: widget.sessionModel.lawyerId))),
        BlocProvider(
            create: (_) => SessionTypeBloc()
              ..add(GetSessionTypeByIdEvent(
                  sessionTypeId: widget.sessionModel.sessionTypeId))),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F4F8),
        appBar: CustomActionAppBar(
          title: 'Session Details',
          actionIcon: Icons.moving_outlined,
          onActionPressed: showPointsEvaluate,
        ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Column(
                                          children: [
                                            Icon(Icons.gavel_rounded,
                                                size: 44,
                                                color: AppColors.darkBlue),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Session #${widget.sessionModel.sessionId}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                      _buildInfoRow(
                                          Icons.description,
                                          'Outcome',
                                          widget.sessionModel.outcome,
                                          22,
                                          16),
                                      const Divider(),
                                      _buildInfoRow(Icons.title, 'Issue Title',
                                          issue.title, 22, 16),
                                      const Divider(),
                                      _buildInfoRow(Icons.person, 'Lawyer',
                                          lawyer.name, 22, 16),
                                      const Divider(),
                                      _buildInfoRow(
                                        Icons.check_circle,
                                        'Is Attend',
                                        widget.sessionModel.isAttend == 1
                                            ? "Yes"
                                            : "No",
                                        22,
                                        16,
                                      ),
                                      const Divider(),
                                      _buildInfoRow(
                                          Icons.category,
                                          'Session Type',
                                          sessionType.type,
                                          22,
                                          16),
                                      const SizedBox(height: 30),
                                      Row(
                                        children: [
                                          Expanded(
                                              child:
                                                  _buildAddDocButton(context)),
                                          const SizedBox(width: 12),
                                          Expanded(
                                              child: _buildAppointmentsButton(
                                                  context)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if (sessionTypeState is SessionTypeFail) {
                            return Center(
                                child: Text(
                                    "Failed to load session type: ${sessionTypeState.errMsg}"));
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      );
                    } else if (lawyerState is LawyerProfileFail) {
                      return Center(
                          child: Text(
                              "Failed to load lawyer: ${lawyerState.errmsg}"));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else if (issueState is IssuesFail) {
                return Center(
                    child: Text("Failed to load issue: ${issueState.errmsg}"));
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
              child:
                  AddDocumentScreen(sessionId: widget.sessionModel.sessionId),
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
            builder: (_) => AppointmentSessionListScreen(
                sessionId: widget.sessionModel.sessionId),
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
