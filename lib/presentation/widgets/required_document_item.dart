import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/required_document_bloc/required_document_bloc.dart';
import '../../blocs/required_document_bloc/required_document_event.dart';
import '../../constant.dart';
import '../../data/models/required_document_model.dart';
import '../../themes.dart';
import '../screens/required_documents/required_document_detials.dart';

class RequiredDocumentItem extends StatelessWidget {
  const RequiredDocumentItem({super.key, required this.requiredDocument});
  final RequiredDocumentModel requiredDocument;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RequiredDocumentDetailsScreen(
              requiredDocument: requiredDocument,
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
                      BlocProvider.of<RequiredDocumentsBloc>(context).add(
                        DeleteRequiredDocumentsEvent(requiredDocumentId: requiredDocument.id),
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
                      'Document #${requiredDocument.id}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 8),

                    _infoRow(Icons.insert_drive_file_outlined, 'Type: ${requiredDocument.requireFileType}'),
                    _infoRow(Icons.verified_user_outlined, 'Status: ${requiredDocument.status}'),

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
