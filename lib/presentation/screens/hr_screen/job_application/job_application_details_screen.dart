import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../blocs/interview_bloc/interview_bloc.dart';
import '../../../../blocs/job_application/job_application_bloc.dart';
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
  State<JobApplicationDetailsScreen> createState() => _JobApplicationDetailsScreenState();
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

  Widget _buildInfoRow(String label, String value, {Color? valueColor, bool isLink = false}) {
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
            child: isLink
                ? GestureDetector(
              onTap: () async {
                final uri = Uri.parse(value);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  height: 1.3,
                ),
              ),
            )
                : Text(
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: CustomActionAppBar(
        title: 'Job Application Details',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
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
                _buildInfoRow('ID', jobApplication.id.toString()),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Name', jobApplication.userName ?? 'N/A'),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Job Title', jobApplication.jobTitle ?? 'N/A'),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Date', jobApplication.date.toString().split(' ')[0]),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Result', jobApplication.result),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Note', jobApplication.note ?? 'Nothing'),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow(
                  'CV Link',
                  jobApplication.cvLink ?? 'No CV uploaded',
                  isLink: jobApplication.cvLink != null,
                ),
                const SizedBox(height: 24),

                // ✅ زر المقابلات
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
                  icon: const Icon(Icons.question_answer),
                  label: const Text(
                    'المقابلات',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),

                const SizedBox(height: 12),

                // زر إضافة مقابلة د
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) =>  InterviewBloc(),
                          child: AddInterviewScreen(
                            jobAppId: jobApplication.id,
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.event, size: 24),
                  label: const Text(
                    'Add Interview',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push<JobApplicationModel>(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => JobApplicationBloc(),
                child: UpdateJobApplicationScreen(jobApplication: jobApplication),
              ),
            ),
          );

          if (result != null) {
            refreshData(result);
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
      ),
    );
  }
}
