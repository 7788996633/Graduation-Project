import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/job_application/job_application_bloc.dart';
import '../../blocs/job_application/job_application_event.dart';
import '../../data/models/job_application_model.dart';
import '../screens/hr_screen/job_application/job_application_details_screen.dart';

class JobApplicationItem extends StatelessWidget {
  const JobApplicationItem({super.key, required this.jobApplication});
  final JobApplicationModel jobApplication;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobApplicationDetailsScreen(
                jobApplication: jobApplication,
              ),
            ),
          );
        },
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<JobApplicationBloc>(context).add(
              DeleteJobApplicationEvent(jobApplicationId: jobApplication.id),
            );
          },
          icon: const Icon(Icons.delete, color: Colors.red),
        ),
        title: Text(
          "Application id (${jobApplication.id})",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),

            Text("job Title: ${jobApplication.jobTitle}"),

          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
