import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../blocs/job_application/job_application_bloc.dart';
import '../../../../blocs/job_application/job_application_event.dart';
import '../../../../blocs/job_application/job_application_state.dart';

import '../../../../data/models/interview_model.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';
import 'update_interview_screen.dart';

class InterviewDetailsScreen extends StatefulWidget {
  final InterviewModel interviewModel;

  const InterviewDetailsScreen({super.key, required this.interviewModel});

  @override
  State<InterviewDetailsScreen> createState() => _InterviewDetailsScreenState();
}

class _InterviewDetailsScreenState extends State<InterviewDetailsScreen> {
  String getFormattedDate(DateTime dateTime) {
    return DateFormat('EEEE, d MMMM yyyy').format(dateTime);
  }

  String getFormattedTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

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

    BlocProvider.of<JobApplicationBloc>(context).add(
      GetJobApplicationByIdEvent(jobApplicationId: widget.interviewModel.jobAppId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: CustomActionAppBar(title: 'Interview Details'),
      body: BlocBuilder<JobApplicationBloc, JobApplicationState>(
        builder: (context, state) {
          if (state is JobApplicationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is JobApplicationLoaded) {
            final job = state.jobApplication;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
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
                          Icons.event_note_outlined,
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
                      _buildInfoRow('Interview ID', widget.interviewModel.id.toString()),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow(
                        'Date',
                        '${getFormattedDate(widget.interviewModel.date)}\n${getFormattedTime(widget.interviewModel.date)}',
                        valueColor: AppColors.darkBlue,
                      ),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Result', widget.interviewModel.result),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Note', widget.interviewModel.note ?? 'Nothing'),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Job Title', job.jobTitle),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is JobApplicationFail) {
            return Center(child: Text('Error: ${state.errMsg}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: BlocBuilder<JobApplicationBloc, JobApplicationState>(
        builder: (context, state) {
          if (state is JobApplicationLoaded) {
            return FloatingActionButton.extended(
              onPressed: () async {
                final result = await Navigator.push<InterviewModel>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => JobApplicationBloc(),
                      child: UpdateInterviewScreen(interview: widget.interviewModel),
                    ),
                  ),
                );

                if (result != null) {
                  BlocProvider.of<JobApplicationBloc>(context).add(
                    GetJobApplicationByIdEvent(jobApplicationId: widget.interviewModel.jobAppId),
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
