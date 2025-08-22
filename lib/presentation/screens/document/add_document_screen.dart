import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../blocs/documents_bloc/document_bloc.dart';
import '../../../blocs/documents_bloc/document_event.dart';
import '../../../blocs/documents_bloc/document_state.dart';

import '../../../themes.dart';

class AddDocumentScreen extends StatefulWidget {
  final int sessionId;

  const AddDocumentScreen({super.key, required this.sessionId});

  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  dynamic selectedFile;
  String? fileName;
  String privacy = 'public';

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;

        if (kIsWeb) {
          selectedFile = result.files.single.bytes; // Uint8List
        } else {
          selectedFile = File(result.files.single.path!); // File
        }
      });
    }
  }

  void submit() {
    if (selectedFile == null || fileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a file')),
      );
      return;
    }

    print(' Session ID: ${widget.sessionId}');
    BlocProvider.of<DocumentBloc>(context).add(
      AddDocumentEvent(
        file: selectedFile,
        fileName: fileName!,
        privacy: privacy,
        sessionId: widget.sessionId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Document',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.grey.shade200,
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
                          'Add Document',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),

                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: const Icon(LucideIcons.uploadCloud, color: Colors.white),
                          onPressed: pickFile,
                          label: Text(
                            fileName ?? 'Choose File',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
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
                            backgroundColor: Colors.green.shade700,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: submit,
                          label: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
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
