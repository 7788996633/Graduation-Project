import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/documents_bloc/document_bloc.dart';
import '../../../constant.dart';
import '../../../data/models/session_model.dart';
import '../appiontment_session_screen/appointment_session_list_screen.dart';
import '../document/add_document_screen.dart';

class SessionDetailsScreen extends StatelessWidget {
  const SessionDetailsScreen({super.key, required this.sessionModel});
  final SessionModel sessionModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Details'),
        backgroundColor: AppColors.darkBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Session ID: ${sessionModel.sessionId}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            Text(
              'Session Outcome: ${sessionModel.outcome}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            Text(
              'Issue ID: ${sessionModel.issueId}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            Text(
              'Lawyer ID: ${sessionModel.lawyerId}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            Text(
              'Is Attend: ${sessionModel.isAttend}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            Text(
              'Session Type ID: ${sessionModel.sessionTypeId}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => DocumentBloc(),
                      child: AddDocumentScreen(sessionId: sessionModel.sessionId),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.upload_file, color: AppColors.darkBlue),
              label: const Text('Add Document'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.darkBlue, width: 2),
                ),
                textStyle: const TextStyle(fontSize: 16, color: AppColors.darkBlue),
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AppointmentSessionListScreen(
                        sessionId: sessionModel.sessionId),
                  ),
                );
              },
              icon: const Icon(Icons.date_range, color: AppColors.darkBlue),
              label: const Text('Appointments'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.darkBlue, width: 2),
                ),
                textStyle: const TextStyle(fontSize: 16, color: AppColors.darkBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
