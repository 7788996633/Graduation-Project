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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
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
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.red.withOpacity(0.1),
            child: IconButton(
              onPressed: () {
                BlocProvider.of<JobApplicationBloc>(context).add(
                  DeleteJobApplicationEvent(jobApplicationId: jobApplication.id),
                );
              },
              icon: const Icon(Icons.delete_forever, color: Colors.red, size: 24),
              tooltip: 'Delete Application',
            ),
          ),
          title: Text(
            jobApplication.jobTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: Color(0xFF1A237E),
              letterSpacing: 0.5,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(0xFF1A237E),
            size: 20,
          ),
        ),
      ),
    );
  }
}
