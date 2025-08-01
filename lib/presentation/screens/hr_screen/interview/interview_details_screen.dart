import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../blocs/job_application/job_application_bloc.dart';
import '../../../../blocs/job_application/job_application_event.dart';
import '../../../../blocs/job_application/job_application_state.dart';
import '../../../../data/models/interview_model.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';

class InterviewDetailsScreen extends StatelessWidget {
  final InterviewModel interviewModel;

  const InterviewDetailsScreen({super.key, required this.interviewModel});

  String getFormattedDate(DateTime dateTime) {
    return DateFormat('EEEE, d MMMM yyyy').format(dateTime);
  }

  String getFormattedTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required double iconSize,
    required double fontSize,
    String? subValue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.darkBlue, size: iconSize),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(text: '$label: ', style: const TextStyle(color: Colors.black87)),
                      TextSpan(text: value, style: const TextStyle(color: AppColors.darkBlue)),
                    ],
                  ),
                ),
                if (subValue != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subValue,
                    style: TextStyle(fontSize: fontSize, color: AppColors.darkBlue),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final iconSize = screenWidth * 0.06;
    final titleFontSize = screenWidth * 0.06;
    final contentFontSize = screenWidth * 0.045;
    final paddingValue = screenWidth * 0.04;

    return BlocProvider(
      create: (_) => JobApplicationBloc()
        ..add(GetJobApplicationByIdEvent(jobApplicationId: interviewModel.jobAppId)),
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F4F8),
        appBar: CustomActionAppBar(title: 'Interview Details'),
        body: Padding(
          padding: EdgeInsets.all(paddingValue),
          child: BlocBuilder<JobApplicationBloc, JobApplicationState>(
            builder: (context, state) {
              if (state is JobApplicationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is JobApplicationFail) {
                return Center(child: Text("Failed: ${state.errMsg}"));
              } else if (state is JobApplicationLoaded) {
                final job = state.jobApplication;

                return SingleChildScrollView(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 12,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(paddingValue),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Icon(Icons.event_note,
                                    size: iconSize * 2, color: AppColors.darkBlue),
                                const SizedBox(height: 10),
                                Text(
                                  'Interview #${interviewModel.id}',
                                  style: TextStyle(
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          _buildInfoRow(
                            icon: Icons.calendar_today,
                            label: 'Date',
                            value: getFormattedDate(interviewModel.date),
                            subValue: getFormattedTime(interviewModel.date),
                            iconSize: iconSize,
                            fontSize: contentFontSize,
                          ),
                          const Divider(),
                          _buildInfoRow(
                            icon: Icons.assignment_turned_in,
                            label: 'Result',
                            value: interviewModel.result,
                            iconSize: iconSize,
                            fontSize: contentFontSize,
                          ),
                          const Divider(),
                          _buildInfoRow(
                            icon: Icons.notes,
                            label: 'Note',
                            value: interviewModel.note ?? 'Nothing',
                            iconSize: iconSize,
                            fontSize: contentFontSize,
                          ),
                          const Divider(),
                          _buildInfoRow(
                            icon: Icons.person,
                            label: 'Applicant',
                            value: job.userName,
                            iconSize: iconSize,
                            fontSize: contentFontSize,
                          ),
                          const Divider(),
                          _buildInfoRow(
                            icon: Icons.work_outline,
                            label: 'Job Title',
                            value: job.jobTitle,
                            iconSize: iconSize,
                            fontSize: contentFontSize,
                          ),


                        ],
                      ),
                    ),
                  ),
                );
              }

              return const SizedBox(); // fallback
            },
          ),
        ),
      ),
    );
  }
}
