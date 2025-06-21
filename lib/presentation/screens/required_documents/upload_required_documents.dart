import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

import '../../../blocs/required_document_bloc/required_document_bloc.dart';
import '../../../blocs/required_document_bloc/required_document_event.dart';
import '../../../blocs/required_document_bloc/required_document_state.dart';

class UploadDocumentScreen extends StatefulWidget {
  final int issueId;

  const UploadDocumentScreen({super.key, required this.issueId});

  @override
  State<UploadDocumentScreen> createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  String? selectedFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Document")),
      body: BlocConsumer<RequiredDocumentsBloc, RequiredDocumentsState>(
        listener: (context, state) {
          if (state is RequiredDocumentsSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Success: ${state.successmsg}")),
            );
          } else if (state is RequiredDocumentsFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.errmsg}")),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles();

                    if (result != null && result.files.single.path != null) {
                      setState(() {
                        selectedFilePath = result.files.single.path!;
                      });
                    }
                  },
                  child: const Text("Choose File"),
                ),
                const SizedBox(height: 10),
                Text(
                  selectedFilePath != null
                      ? selectedFilePath!.split('/').last
                      : "No file selected",
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: selectedFilePath != null
                      ? () {
                    context.read<RequiredDocumentsBloc>().add(
                      UploadRequiredDocumentEvent(
                        issueId: widget.issueId,
                        filePath: selectedFilePath!,
                      ),
                    );
                  }
                      : null,
                  child: state is RequiredDocumentsLoading
                      ? const CircularProgressIndicator()
                      : const Text("Upload"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
