import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/job_application/job_application_bloc.dart';
import '../../blocs/job_application/job_application_event.dart';
import '../../data/models/job_application_model.dart';
import '../../themes.dart';
import '../screens/hr_screen/job_application/job_application_details_screen.dart';

class JobApplicationItem extends StatelessWidget {
  const JobApplicationItem({super.key, required this.jobApplication});

  final JobApplicationModel jobApplication;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8, vertical: 5),
      child: Card(
        elevation: 8,
        shadowColor: Colors.blueGrey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            final updatedJob = await Navigator.push<JobApplicationModel>(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => JobApplicationBloc(),
                  child: JobApplicationDetailsScreen(jobApplication: jobApplication),
                ),
              ),
            );

            if (updatedJob != null) {
              // أعِد تحميل بيانات القائمة بعد التحديث
              context.read<JobApplicationBloc>().add(
                GetAllJobApplicationsEvent(hiringReqId: jobApplication.hiringRequestId),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.white, Colors.blue.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.darkBlue.withOpacity(0.1),
                  child: const Icon(
                    Icons.assignment_ind_rounded,
                    color: AppColors.darkBlue,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobApplication.userName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.info_outline, size: 18, color: Colors.grey),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: _statusColor(jobApplication.status).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              jobApplication.status[0].toUpperCase() + jobApplication.status.substring(1),
                              style: TextStyle(
                                color: _statusColor(jobApplication.status),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.darkBlue,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      case 'interview':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
