import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../blocs/documents_bloc/document_bloc.dart';
import '../../../blocs/documents_bloc/document_event.dart';
import '../../../blocs/documents_bloc/document_state.dart';

class AddDocumentScreen extends StatefulWidget {
  final int sessionId;
  const AddDocumentScreen({super.key, required this.sessionId});

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  File? selectedFile;
  String privacy = 'public';

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  void submit() {
    if (selectedFile != null) {
      BlocProvider.of<DocumentBloc>(context).add(
        AddDocumentEvent(
          file: selectedFile!,
          privacy: privacy,
          sessionId: widget.sessionId,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a file')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Document', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade400,
        elevation: 0,
      ),
      body: Container(
        color: Colors.deepPurple.shade50,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<DocumentBloc, DocumentState>(
              listener: (context, state) {
                if (state is DocumentSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.successmsg)),
                  );
                  Navigator.pop(context);
                } else if (state is DocumentFail) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errmsg)),
                  );
                }
              },
              builder: (context, state) {
                if (state is DocumentLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Document Details',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: const Icon(LucideIcons.uploadCloud),
                          onPressed: pickFile,
                          label: Text(
                            selectedFile == null ? 'Choose File' : 'File Selected',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 20),
                        InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Privacy',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: privacy,
                              onChanged: (val) => setState(() => privacy = val!),
                              items: const [
                                DropdownMenuItem(value: 'public', child: Text('Public')),
                                DropdownMenuItem(value: 'private', child: Text('Private')),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: const Icon(Icons.send),
                          onPressed: submit,
                          label: const Text('Submit', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
