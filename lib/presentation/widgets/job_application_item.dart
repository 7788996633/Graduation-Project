import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/job_application/job_application_bloc.dart';

import '../../data/models/job_application_model.dart';
import '../../themes.dart';
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
          border: Border.all(color: AppColors.darkBlue, width: 1.5),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => JobApplicationBloc(),
                  child: JobApplicationDetailsScreen(
                    jobApplication: jobApplication,
                  ),
                ),
              ),
            );
          },
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey.withOpacity(0.1),
            child: const Icon(
              Icons.assignment_ind,
              color: AppColors.darkBlue,
              size: 24,
            ),
          ),
          title: Text(
            'Applicant: ${jobApplication.userName}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize:15,
              color: AppColors.darkBlue,
            ),
          ),
          subtitle: Text(
            'Job Title: ${jobApplication.jobTitle}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
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
