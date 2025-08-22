import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../blocs/delegations_bloc/delegations_bloc.dart';
import '../../../blocs/delegations_bloc/delegations_event.dart';
import '../../../blocs/delegations_bloc/delegations_state.dart';
import '../../../themes.dart';

class SubmitDelegationScreen extends StatefulWidget {
  final int sessionId;
  final int originalLawyerId;

  const SubmitDelegationScreen({
    super.key,
    required this.sessionId,
    required this.originalLawyerId,
  });

  @override
  State<SubmitDelegationScreen> createState() => SubmitDelegationScreenState();
}

class SubmitDelegationScreenState extends State<SubmitDelegationScreen> {
  dynamic selectedFile;
  String? fileName;

  final TextEditingController adminNoteController = TextEditingController();

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
        const SnackBar(content: Text('Please select a delegation file')),
      );
      return;
    }

    String adminNote = adminNoteController.text.trim();

    BlocProvider.of<DelegationBloc>(context).add(
      AddDelegationEvent(
        file: selectedFile,
        sessionId: widget.sessionId,
        originalLawyerId: widget.originalLawyerId,
      ),
    );
  }

  @override
  void dispose() {
    adminNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Submit Delegation',
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
            child: BlocConsumer<DelegationBloc, DelegationState>(
              listener: (context, state) {
                if (state is DelegationSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.successMsg),
                      backgroundColor: Colors.greenAccent,
                    ),
                  );
                  Navigator.pop(context);
                } else if (state is DelegationFail) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errMsg),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is DelegationLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Submit Your Delegation',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: const Icon(LucideIcons.uploadCloud,
                              color: Colors.white),
                          onPressed: pickFile,
                          label: Text(
                            fileName ?? 'Choose Delegation File',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: submit,
                          label: const Text(
                            'Submit Approval',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
