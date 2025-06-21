import 'package:flutter/material.dart';
import '../../../data/models/required_document_model.dart';

class RequiredDocumentDetailsScreen extends StatelessWidget {
  const RequiredDocumentDetailsScreen({super.key, required this.requiredDocument});
  final RequiredDocumentModel requiredDocument;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Required Document Details'),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${requiredDocument.id}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text('Type: ${requiredDocument.requireFileType}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text('Note: ${requiredDocument.note ?? "No note"}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
        //    Text('Status: ${requiredDocument.status}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            if (requiredDocument.file != null && requiredDocument.file!.isNotEmpty) ...[
              const Text('Attached File:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  requiredDocument.file!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Text('Failed to load image'),
                ),
              ),
            ] else
              const Text('No attached file', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
