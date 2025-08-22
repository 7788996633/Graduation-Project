import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../../../themes.dart';

class CreateLawyerProfileScreen extends StatefulWidget {
  const CreateLawyerProfileScreen({super.key});

  @override
  State<CreateLawyerProfileScreen> createState() =>
      _CreateLawyerProfileScreenState();
}

class _CreateLawyerProfileScreenState extends State<CreateLawyerProfileScreen> {
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController experienceYearsController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? selectedCertificateFile;
  String? certificateFileName;
  File? selectedImage;
  String? resultMessage;

  Future<void> _pickCertificate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedCertificateFile = File(result.files.single.path!);
        certificateFileName = result.files.single.name;
      });
    }
  }

  Future<void> _pickProfileImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
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
            fillColor: AppColors.darkBlue,
            hintStyle: const TextStyle(color: Colors.white54),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white24),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        title: const Text(
          "Create Lawyer Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.darkBlue,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              // صورة المحامي
              Center(
                child: GestureDetector(
                  onTap: _pickProfileImage,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.darkBlue.withOpacity(0.3),
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage!)
                            : null,
                        child: selectedImage == null
                            ? const Icon(Icons.camera_alt,
                            size: 30, color: Colors.white)
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),

              buildStyledTextField('License Number', licenseNumberController),
              const SizedBox(height: 12),
              buildStyledTextField('Experience Years', experienceYearsController),
              const SizedBox(height: 12),
              buildStyledTextField('Specialization', specializationController),
              const SizedBox(height: 12),
              buildStyledTextField('Salary', salaryController),
              const SizedBox(height: 20),

              // زر اختيار الشهادة
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _pickCertificate,
                icon: const Icon(Icons.upload_file),
                label: Text(
                  certificateFileName ?? 'Choose Certificate File',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // زر الإرسال مع Bloc
              BlocConsumer<LawyerProfileBloc, LawyerProfileState>(
                listener: (context, state) {
                  if (state is LawyerProfileSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.successmsg),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is LawyerProfileFail) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errmsg),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton.icon(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        if (selectedCertificateFile == null || certificateFileName == null) {
                          setState(() {
                            resultMessage = "Please select a certificate file first.";
                          });
                          return;
                        }

                        BlocProvider.of<LawyerProfileBloc>(context).add(
                          CreateLawyerProfileEvent(
                            licenseNumber: licenseNumberController.text,
                            experienceYears: experienceYearsController.text,
                            specialization: specializationController.text,
                            certificatePath: selectedCertificateFile!.path,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.check_circle, color: Colors.white),
                    label: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                },
              ),

              if (resultMessage != null) ...[
                const SizedBox(height: 10),
                Text(
                  resultMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
