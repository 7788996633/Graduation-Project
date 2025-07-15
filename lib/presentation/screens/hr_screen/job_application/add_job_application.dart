import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/job_application/job_application_bloc.dart';
import '../../../../blocs/job_application/job_application_event.dart';
import '../../../../blocs/job_application/job_application_state.dart';
import '../../../widgets/build_custom_appbar_detials.dart';
import '../../../widgets/elevated_button_submit.dart';

class AddJobApplicationScreen extends StatefulWidget {
  final int hiringReqId;

  const AddJobApplicationScreen({super.key, required this.hiringReqId});

  @override
  State<AddJobApplicationScreen> createState() => _AddJobApplicationScreenState();
}

class _AddJobApplicationScreenState extends State<AddJobApplicationScreen> {
  File? _cvFile;

  Future<void> _pickCVFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _cvFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: buildCustomAppBar("Add Job Application"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<JobApplicationBloc, JobApplicationState>(
          listener: (context, state) {
            if (state is JobApplicationSuccess) {
              setState(() {
                _cvFile = null;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successMsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is JobApplicationFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed: ${state.errMsg}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Create New Job Application",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),

                    ElevatedButton.icon(
                      icon: const Icon(Icons.upload_file),
                      label: Text(
                        _cvFile != null
                            ? _cvFile!.path.split('/').last
                            : "Select CV (PDF)",
                      ),
                      onPressed: _pickCVFile,
                    ),


                    const SizedBox(height: 30),
                    state is JobApplicationLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                      height: 50,
                      child: CustomElevatedButtonSubmit(
                        label: "Submit",
                        onPressed: () {
                          if (_cvFile == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please select a CV file."),
                                backgroundColor: Colors.orange,
                              ),
                            );
                            return;
                          }

                          BlocProvider.of<JobApplicationBloc>(context).add(
                            AddJobApplicationEvent(
                              hiringReqId: widget.hiringReqId,
                              cv: _cvFile!,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
