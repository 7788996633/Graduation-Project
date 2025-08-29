import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../blocs/interview_bloc/interview_bloc.dart';
import '../../../../blocs/job_application/job_application_bloc.dart';
import '../../../../constant.dart';
import '../../../../data/models/job_application_model.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';
import '../interview/add_interview_screen.dart';
import '../interview/list_interview_screen.dart';
import 'update_job_application.dart';

class JobApplicationDetailsScreen extends StatefulWidget {
  final JobApplicationModel jobApplication;

  const JobApplicationDetailsScreen({super.key, required this.jobApplication});

  @override
  State<JobApplicationDetailsScreen> createState() =>
      _JobApplicationDetailsScreenState();
}

class _JobApplicationDetailsScreenState extends State<JobApplicationDetailsScreen> {
  late JobApplicationModel jobApplication;

  @override
  void initState() {
    super.initState();
    jobApplication = widget.jobApplication;
  }

  void refreshData(JobApplicationModel updated) {
    setState(() {
      jobApplication = updated;
    });
  }

  String prepareFullUrl(String value) {
    const String baseUrl = 'http://192.168.1.10/LawCompany/public/';
    if (value.startsWith('http')) {
      return value;
    } else {
      return '$baseUrl$value';
    }
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool isLink = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.darkBlue, size: 22),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: isLink
                ? GestureDetector(
              onTap: () async {
                if (value.isEmpty) return;
                final uri = Uri.parse(prepareFullUrl(value));
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not open URL')),
                  );
                }
              },
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.darkBlue,
                  decoration: TextDecoration.underline,
                  height: 1.3,
                ),
              ),
            )
                : Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: const CustomActionAppBar(title: 'Job Application Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 10,
          color: Colors.white,
          shadowColor: Colors.blueGrey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.assignment_ind_rounded,
                    size: 72,
                    color: AppColors.darkBlue,
                  ),
                ),
                const SizedBox(height: 20),

                _buildInfoRow(
                  icon: Icons.person,
                  label: 'Name',
                  value: jobApplication.userName,
                ),


                _buildInfoRow(
                  icon: Icons.date_range_outlined,
                  label: 'Date',
                  value: jobApplication.date.toString().split(' ')[0],
                ),
                _buildInfoRow(
                  icon: Icons.picture_as_pdf,
                  label: 'CV Link',
                  value: jobApplication.cvLink,
                  isLink: jobApplication.cvLink.isNotEmpty,
                ),
                _buildInfoRow(
                  icon: Icons.insights_outlined,
                  label: 'Status',
                  value: jobApplication.status,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => InterviewBloc(),
                          child: ListInterviewsScreen(
                            jobApplicationId: jobApplication.id,
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.question_answer, color: Colors.white),
                  label: const Text('View Interviews', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 12),
                if (myRole != null && myRole.toLowerCase() == 'hr')
                  ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => InterviewBloc(),
                          child: AddInterviewScreen(jobAppId: jobApplication.id),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.event, size: 22, color: Colors.white),
                  label: const Text('Add Interview', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final updatedJob = await Navigator.push<JobApplicationModel>(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => JobApplicationBloc(),
                child: UpdateJobApplicationScreen(jobApplication: jobApplication),
              ),
            ),
          );

          if (updatedJob != null) {
            refreshData(updatedJob);
          }
        },
        icon: const Icon(Icons.edit, color: Colors.white),
        label: const Text(
          'Edit',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: AppColors.darkBlue,
      ),
    );
  }
}
