import 'package:flutter/material.dart';
import '../../blocs/interview_bloc/interview_bloc.dart';
import '../../blocs/interview_bloc/interview_event.dart';
import '../../data/models/interview_model.dart';
import '../../themes.dart';
import '../screens/hr_screen/interview/interview_details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterviewItem extends StatelessWidget {
  const InterviewItem({super.key, required this.interviewModel});
  final InterviewModel interviewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 1.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
        shadowColor: Colors.blueAccent.withOpacity(0.3),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InterviewDetailsScreen(interviewModel: interviewModel),
              ),
            );
          },
          leading: Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                BlocProvider.of<InterviewBloc>(context).add(
                  DeleteInterviewEvent(interviewId: interviewModel.id),
                );
              },
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              tooltip: 'Delete Interview',
            ),
          ),
          title: const Text(
            "Interview",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color:  AppColors.darkBlue,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              "Date: ${interviewModel.date.toLocal().toString().split(' ')[0]}",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right,
            size: 28,
            color: AppColors.darkBlue,
          ),
        ),
      ),
    );
  }
}
