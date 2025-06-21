import 'package:flutter/material.dart';

import '../../../data/models/session_model.dart';
import '../appiontment_session_screen/appointment_session_list_screen.dart';
import '../document/add_document_screen.dart';

import '../required_documents/add_required_documents.dart';

class SessionDetailsScreen extends StatelessWidget {
  const SessionDetailsScreen({super.key, required this.sessionModel});
  final SessionModel sessionModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Details'),
        backgroundColor: Colors.deepPurple.shade400,
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

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        AddDocumentScreen(sessionId: sessionModel.sessionId),
                  ),
                );
              },
              icon: const Icon(Icons.upload_file),
              label: const Text('Add Document'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontSize: 16),
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
              icon: const Icon(Icons.date_range),
              label: const Text('Appointments'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 15),

            // الزر الجديد لإضافة Required Document
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddRequiredDocumentScreen(
                      issueId: sessionModel.sessionId, // تمرير sessionId كـ issueId
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.note_add),
              label: const Text('Add Required Document'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
