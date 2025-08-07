import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/documents_bloc/document_bloc.dart';
import '../../blocs/documents_bloc/document_event.dart';
import '../../data/models/document_model.dart';
import '../../themes.dart';
import '../screens/document/document_detials_screen.dart';


class DocumentItem extends StatelessWidget {
  const DocumentItem({super.key, required this.document});
  final DocumentModel document;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DocumentDetailsScreen(
              document: document,
            ),
          ),
        );
      },
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.deepPurple.withOpacity(0.2),
        color: Colors.deepPurple.shade50,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delete button
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                    onPressed: () {
                      BlocProvider.of<DocumentBloc>(context).add(
                        DeleteDocumentEvent(documentId: document.id),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Information section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Document #${document.id}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _infoRow(Icons.confirmation_number_outlined, 'Session ID: ${document.sessionId}'),
                    _infoRow(Icons.security_outlined, 'Privacy: ${document.privacy}'),
                    _infoRow(Icons.security_outlined, 'session : ${document.sessionId}'),
                    _infoRow(Icons.security_outlined, 'file : ${document.file}'),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.darkBlue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14.5, color: Colors.black87, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
