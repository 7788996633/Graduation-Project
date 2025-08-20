import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/delegations_bloc/delegations_bloc.dart';
import '../../../blocs/documents_bloc/document_bloc.dart';
import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../blocs/issue_progress_reports/issue_progress_reports_bloc.dart';
import '../../../blocs/issue_progress_reports/issue_progress_reports_event.dart';
import '../../../blocs/issue_progress_reports/issue_progress_reports_state.dart';
import '../../../blocs/session_points_bloc/session_points_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_event.dart';
import '../../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../../blocs/sessions_bloc/sessions_event.dart';
import '../../../blocs/sessions_bloc/sessions_state.dart';
import '../../../constant.dart';
import '../../../data/models/lawyer_model.dart';
import '../../../data/models/session_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/custom_text_field.dart';
import '../appiontment_session_screen/appointment_session_list_screen.dart';
import '../delegations_screen/submit_delegation_screen.dart';
import '../document/add_document_screen.dart';

class SessionDetailsScreen extends StatefulWidget {
  final SessionModel sessionModel;

  const SessionDetailsScreen({super.key, required this.sessionModel});

  @override
  State<SessionDetailsScreen> createState() => _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends State<SessionDetailsScreen> {
  TextEditingController reportController = TextEditingController();
  Widget _buildInfoRow(IconData icon, String label, String value,
      double iconSize, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,
              color: isLight
                  ? AppColors.darkBlue
                  : const Color.fromARGB(255, 117, 165, 238),
              size: iconSize),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: TextStyle(
                      color: getCurrentTheme()['NormalText'],
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      color: isLight
                          ? AppColors.darkBlue
                          : const Color.fromARGB(255, 117, 165, 238),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController outComeController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  bool isAddingOutCome = false;
  late bool isCurrentLawyer;
  late LawyerModel lawyer;
  @override
  void initState() {
    lawyer = widget.sessionModel.lawyer;
    isCurrentLawyer = (lawyer.licenseNumber.trim() == myLicenesNumber.trim());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "object $isCurrentLawyer ${lawyer.licenseNumber} object$myLicenesNumber");
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
            create: (_) => SessionTypeBloc()
              ..add(GetSessionTypeByIdEvent(
                  sessionTypeId: widget.sessionModel.sessionTypeId))),
      ],
      child: BlocConsumer<SessionsBloc, SessionsState>(
        listener: (context, state) {
          if (state is SessionsSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successmsg),
                backgroundColor: Colors.greenAccent,
              ),
            );
          } else if (state is SessionsFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errmsg),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: getCurrentTheme()['BackGorund'],
            appBar: CustomActionAppBar(
              title: 'Session Details',
              actionIcon: myRole == 'admin'
                  ? Icons.moving_outlined
                  : myRole == 'lawyer' && isCurrentLawyer
                      ? Icons.find_replace
                      : null,
              onActionPressed: myRole == 'admin'
                  ? showPointsEvaluate
                  : myRole == 'lawyer' && isCurrentLawyer
                      ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => DelegationBloc(),
                                child: SubmitDelegationScreen(
                                  sessionId: widget.sessionModel.sessionId,
                                  originalLawyerId:
                                      widget.sessionModel.lawyerId,
                                ),
                              ),
                            ),
                          );
                        }
                      : null,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<IssuesBloc, IssuesState>(
                builder: (context, issueState) {
                  if (issueState is IssuesLoadedSuccessFully) {
                    final issue = issueState.issue;

                    return BlocBuilder<SessionTypeBloc, SessionTypeState>(
                      builder: (context, sessionTypeState) {
                        if (sessionTypeState is SessionTypeLoaded) {
                          final sessionType = sessionTypeState.session;

                          return SingleChildScrollView(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                  width: isLight ? 0 : 2,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              elevation: 12,
                              color: getCurrentTheme()['BackGorund'],
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.gavel_rounded,
                                            size: 44,
                                            color: isLight
                                                ? AppColors.darkBlue
                                                : const Color.fromARGB(
                                                    255, 117, 165, 238),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Session #${widget.sessionModel.sessionId}',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: getCurrentTheme()[
                                                  'NormalText'],
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (isCurrentLawyer) {
                                          isAddingOutCome = !isAddingOutCome;
                                          setState(() {});
                                        }
                                      },
                                      child: _buildInfoRow(
                                          Icons.description,
                                          'Outcome',
                                          widget.sessionModel.outcome,
                                          22,
                                          16),
                                    ),
                                    if (isCurrentLawyer &&
                                        isAddingOutCome &&
                                        widget.sessionModel.isAttend == 1) ...[
                                      CustomTextFeild(
                                        text: "Add outcome...",
                                        controller: outComeController,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                          ),
                                          onPressed: () {
                                            BlocProvider.of<SessionsBloc>(
                                                    context)
                                                .add(
                                              UpdateSessionEvent(
                                                outcome: outComeController.text,
                                                isAttend: widget
                                                    .sessionModel.isAttend,
                                                sessionId: widget
                                                    .sessionModel.sessionId,
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Confirm",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    const Divider(),
                                    _buildInfoRow(Icons.title, 'Issue Title',
                                        issue.title, 22, 16),
                                    const Divider(),
                                    _buildInfoRow(
                                        Icons.person,
                                        'Lawyer',
                                        widget.sessionModel.lawyer.name,
                                        22,
                                        16),
                                    const Divider(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: isCurrentLawyer ? 0 : 8),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.check_circle,
                                                  color: isLight
                                                      ? AppColors.darkBlue
                                                      : const Color.fromARGB(
                                                          255, 117, 165, 238),
                                                  size: 22,
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    children: [
                                                      TextSpan(
                                                        text: 'Is Attend: ',
                                                        style: TextStyle(
                                                          color:
                                                              getCurrentTheme()[
                                                                  'NormalText'],
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: widget.sessionModel
                                                                    .isAttend ==
                                                                1
                                                            ? "Yes"
                                                            : "No",
                                                        style: TextStyle(
                                                          color: isLight
                                                              ? AppColors
                                                                  .darkBlue
                                                              : const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  117,
                                                                  165,
                                                                  238),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            if (isCurrentLawyer &&
                                                widget.sessionModel.isAttend !=
                                                    1)
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                ),
                                                onPressed: () {
                                                  BlocProvider.of<SessionsBloc>(
                                                          context)
                                                      .add(
                                                    MarkSessionAsAttendanceEvent(
                                                      sessionId: widget
                                                          .sessionModel
                                                          .sessionId,
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "Set attendance",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    _buildInfoRow(
                                        Icons.category,
                                        'Session Type',
                                        sessionType.type,
                                        22,
                                        16),
                                    const Divider(),
                                    if (isCurrentLawyer &&
                                        widget.sessionModel.isAttend == 1)
                                      BlocConsumer<IssueProgressReportBloc,
                                          IssueProgressReportState>(
                                        listener: (context, state) {
                                          if (state
                                              is IssueProgressReportSuccess) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(state.successMsg),
                                                backgroundColor:
                                                    Colors.greenAccent,
                                              ),
                                            );
                                            reportController.clear();
                                          } else if (state
                                              is IssueProgressReportFail) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(state.errMsg),
                                                backgroundColor:
                                                    Colors.redAccent,
                                              ),
                                            );
                                          }
                                        },
                                        builder: (context, state) {
                                          return Container(
                                            margin: EdgeInsets.only(top: 20),
                                            width: double.infinity,
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              gradient: RadialGradient(
                                                center: Alignment.center,
                                                radius: 5,
                                                colors: isLight
                                                    ? [
                                                        AppColors.darkBlue,
                                                        AppColors.softGray,
                                                        AppColors.white,
                                                      ]
                                                    : [
                                                        Colors.black,
                                                        AppColors.softGray,
                                                        AppColors.white,
                                                      ],
                                              ),
                                              border: Border.all(
                                                strokeAlign: 2,
                                                width: 3,
                                                color: AppColors.white,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                8,
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Enter your report here",
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                CustomTextFeild(
                                                  text: "Report...",
                                                  controller: reportController,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Center(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      fixedSize: Size(
                                                        200,
                                                        30,
                                                      ),
                                                      backgroundColor:
                                                          Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  IssueProgressReportBloc>(
                                                              context)
                                                          .add(
                                                        AddIssueProgressReportEvent(
                                                          sessionId: widget
                                                              .sessionModel
                                                              .sessionId,
                                                          report:
                                                              reportController
                                                                  .text,
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Submit",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    const SizedBox(height: 30),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: _buildAddDocButton(context)),
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
                  } else if (issueState is IssuesFail) {
                    return Center(
                        child:
                            Text("Failed to load issue: ${issueState.errmsg}"));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          );
        },
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
