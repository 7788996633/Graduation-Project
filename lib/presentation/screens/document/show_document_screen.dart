import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';

import '../../../blocs/documents_bloc/document_bloc.dart';
import '../../../blocs/documents_bloc/document_event.dart';
import '../../../blocs/documents_bloc/document_state.dart';

class ShowDocumentScreen extends StatelessWidget {
  final int sessionId;
  final int documentId;

  const ShowDocumentScreen({
    super.key,
    required this.sessionId,
    required this.documentId,
  });

  Future<void> _openLocalFile(String fileName) async {
    final String path = '/storage/emulated/0/Download/$fileName';
    final result = await OpenFilex.open(path); // ✅ تم التعديل

    if (result.type != ResultType.done) {
      debugPrint('Failed to open file: $path');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Document Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade700,
        elevation: 4,
        shadowColor: Colors.deepPurpleAccent,
      ),
      backgroundColor: Colors.deepPurple.shade50,
      body: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          if (state is DocumentInitial) {
            context.read<DocumentBloc>().add(
              ShowDocumentByIdEvent(
                documentId: documentId,
                sessionId: sessionId,
              ),
            );
            return const Center(child: CircularProgressIndicator());
          } else if (state is DocumentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DocumentLoadedSuccessfully) {
            final doc = state.document;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 12,
                    shadowColor: Colors.deepPurple.shade200,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Icon(
                              Icons.insert_drive_file_rounded,
                              size: 80,
                              color: Colors.deepPurple.shade400,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Text(
                              'Document Details',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple.shade700,
                              ),
                            ),
                          ),
                          const Divider(height: 40, thickness: 2),
                          _buildDetailRow('Document ID:', doc.id.toString(), theme),
                          const SizedBox(height: 15),
                          _buildDetailRow('Privacy:', doc.privacy.capitalize(), theme),
                          const SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.insert_drive_file, color: Colors.deepPurple),
                              const SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _openLocalFile(doc.file),
                                  child: Text(
                                    doc.file,
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          _buildDetailRow('Created At:', doc.createdAt.toString(), theme),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      _openLocalFile(doc.file);
                    },
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Open File'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DocumentFail) {
            return Center(
              child: Text(
                'Failed to load document:\n${state.errmsg}',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
              ),
            );
          } else {
            return Center(
              child: Text(
                'No data available',
                style: theme.textTheme.bodyLarge,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple.shade600,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.normal,
              color: Colors.deepPurple.shade900,
            ),
          ),
        ),
      ],
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
}
