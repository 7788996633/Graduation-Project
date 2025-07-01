import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

import 'package:path/path.dart';

import '../../../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import 'lawyer_profile_screen.dart';

class CreateLawyerProfileScreen extends StatefulWidget {
  const CreateLawyerProfileScreen({super.key});

  @override
  State<CreateLawyerProfileScreen> createState() =>
      _CreateLawyerProfileScreenState();
}

class _CreateLawyerProfileScreenState extends State<CreateLawyerProfileScreen> {
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController experienceYearsController =
      TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? certificateFilePath;
  String? resultMessage;

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  Future<void> _pickCertificate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'docx'],
    );

    if (result != null) {
      setState(() {
        certificateFilePath = result.files.single.path;
      });
      print("📎 Certificate file selected: $certificateFilePath");
    } else {
      print("📭 No file selected");
    }
  }

  Widget buildStyledTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          validator: nameValidator,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFD9D9D9),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: Color(0xFF8E6944), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF8E6944), width: 2),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: Color(0xFF8E6944), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: const Text("Create Lawyer Profile",
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF472A0C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add As A Lawyer",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 16),
                buildStyledTextField('License Number', licenseNumberController),
                const SizedBox(height: 10),
                buildStyledTextField(
                    'Experience Years', experienceYearsController),
                const SizedBox(height: 10),
                buildStyledTextField(
                    'Specialization', specializationController),
                const SizedBox(height: 10),
                buildStyledTextField('Salary', salaryController),
                const SizedBox(height: 10),
                MaterialButton(
                  color: const Color(0xFF472A0C),
                  onPressed: _pickCertificate,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add certificates ",
                          style: TextStyle(color: Colors.white)),
                      Icon(Icons.upload_file, color: Colors.white),
                    ],
                  ),
                ),
                if (certificateFilePath != null)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "📎 File: ${basename(certificateFilePath!)}",
                      style: const TextStyle(color: Color(0xFF8E6944)),
                    ),
                  ),
                const SizedBox(height: 10),
                BlocConsumer<LawyerProfileBloc, LawyerProfileState>(
                  listener: (context, state) {
                    if (state is LawyerProfileSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.successmsg,
                              style: const TextStyle(fontSize: 16)),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => LawyerProfileBloc(),
                            child: const LawyerProfileScreen(),
                          ),
                        ),
                      );
                    } else if (state is LawyerProfileFail) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errmsg,
                              style: const TextStyle(fontSize: 16)),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            if (certificateFilePath == null) {
                              setState(() {
                                resultMessage =
                                    "Please select a certificate file first.";
                              });
                              return;
                            }

                            BlocProvider.of<LawyerProfileBloc>(context).add(
                              CreateLawyerProfileEvent(
                                licenseNumber: licenseNumberController.text,
                                experienceYears: experienceYearsController.text,
                                specialization: specializationController.text,
                                certificatePath: certificateFilePath!,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0F6829),
                          foregroundColor: Colors.white,
                          elevation: 8,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Submit'),
                      ),
                    );
                  },
                ),
                if (resultMessage != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    resultMessage!,
                    style: TextStyle(
                      color: resultMessage!.startsWith("Error")
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
