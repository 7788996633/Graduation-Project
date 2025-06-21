import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/required_document_bloc/required_document_bloc.dart';
import '../../blocs/required_document_bloc/required_document_event.dart';
import '../../data/models/required_document_model.dart';
import '../screens/required_documents/required_document_detials.dart';

class RequiredDocumentItem extends StatelessWidget {
  const RequiredDocumentItem({super.key, required this.requiredDocument});
  final RequiredDocumentModel requiredDocument;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
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
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<RequiredDocumentsBloc>(context).add(
              DeleteRequiredDocumentsEvent(requiredDocumentId: requiredDocument.id),
            );
          },
          icon: const Icon(Icons.delete, color: Colors.red),
        ),
        title: Text(
          'ID: ${requiredDocument.id}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Issue ID: ${requiredDocument.issueId}'),
              Text('Type: ${requiredDocument.requireFileType}'),
            // Text('Status: ${requiredDocument.status}'),
              Text('Note: ${requiredDocument.note ?? "—"}'),
              Text('File: ${requiredDocument.file ?? "No file"}'),
            ],
          ),
        ),
      ),
    );
  }
}
