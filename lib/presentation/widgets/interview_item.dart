import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/interview_bloc/interview_bloc.dart';
import '../../blocs/interview_bloc/interview_event.dart';

import '../../blocs/interview_bloc/interviews_state.dart';
import '../../blocs/job_application/job_application_bloc.dart';
import '../../constant.dart';
import '../../data/models/interview_model.dart';
import '../../themes.dart';
import '../screens/hr_screen/interview/interview_details_screen.dart';

class InterviewItem extends StatefulWidget {
  const InterviewItem({super.key, required this.interviewModel});
  final InterviewModel interviewModel;

  @override
  State<InterviewItem> createState() => _InterviewItemState();
}

class _InterviewItemState extends State<InterviewItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: BlocConsumer<InterviewBloc, InterviewState>(
        listener: (context, state) {
          if (state is InterviewSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(state.successMsg),
              ),
            );
          } else if (state is InterviewFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(state.errMsg),
              ),
            );
          }
        },
        builder: (context, state) {
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => JobApplicationBloc(),
                    child: InterviewDetailsScreen(
                      interviewModel: widget.interviewModel,
                      myRole: myRole,
                    ),
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.darkBlue.withOpacity(0.2),
                      child: const Icon(
                        Icons.person_search,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Interview",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBlue,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Date: ${widget.interviewModel.date.toLocal().toString().split(' ')[0]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (myRole != null && myRole.toLowerCase() == 'hr')
                    IconButton(
                      onPressed: () {
                        context.read<InterviewBloc>().add(
                          DeleteInterviewEvent(
                            interviewId: widget.interviewModel.id,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: AppColors.darkBlue,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
