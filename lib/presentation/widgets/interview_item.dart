import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/interview_bloc/interview_bloc.dart';
import '../../blocs/interview_bloc/interview_event.dart';
import '../../data/models/interview_model.dart';
import '../screens/hr_screen/interview/interview_details_screen.dart';

class InterviewItem extends StatelessWidget {
  const InterviewItem({super.key, required this.interviewModel});
  final InterviewModel interviewModel;

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
              builder: (context) => InterviewDetailsScreen(
                interviewModel: interviewModel,
              ),
            ),
          );
        },
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<InterviewBloc>(context).add(
              DeleteInterviewEvent(interviewId: interviewModel.id),
            );
          },
          icon: const Icon(Icons.delete, color: Colors.red),
        ),
        title: Text(
          "Interview #${interviewModel.id}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text("Date: ${interviewModel.date.toLocal().toString().split(' ')[0]}"),
            Text("Result: ${interviewModel.result}"),
            Text("Note: ${interviewModel.note?.isNotEmpty == true ? interviewModel.note : 'nothing'}"),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
