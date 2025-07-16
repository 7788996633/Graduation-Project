import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/presentation/screens/home/lawyer_home_page.dart';
import 'package:path/path.dart';

import '../../../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../../../data/models/lawyer_model.dart';

class EditLawyerProfileScreen extends StatefulWidget {
  final LawyerModel lawyer;

  const EditLawyerProfileScreen({super.key, required this.lawyer});

  @override
  State<EditLawyerProfileScreen> createState() =>
      _EditLawyerProfileScreenState();
}

class _EditLawyerProfileScreenState extends State<EditLawyerProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController specializationController;
  late TextEditingController licenseController;
  late TextEditingController addressController;
  late TextEditingController ageController;
  late TextEditingController expereinceYearsController;
  late TextEditingController phoneController;

  String? certificateFilePath; // null إذا ما تغير
  File? _pickedImage;

  final Color customColor = const Color(0xFF472A0C);

  @override
  void initState() {
    super.initState();
    specializationController =
        TextEditingController(text: widget.lawyer.specialization);
    licenseController =
        TextEditingController(text: widget.lawyer.licenseNumber);
    addressController = TextEditingController(text: widget.lawyer.address);
    ageController = TextEditingController(text: widget.lawyer.age.toString());
    expereinceYearsController =
        TextEditingController(text: widget.lawyer.experienceYears.toString());
    phoneController = TextEditingController(text: widget.lawyer.phone);
  }

  @override
  void dispose() {
    specializationController.dispose();
    licenseController.dispose();
    addressController.dispose();
    ageController.dispose();
    expereinceYearsController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickCertificate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        certificateFilePath = result.files.single.path!;
      });
    }
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _pickedImage = File(result.files.single.path!);
      });
    }
  }

  void _saveProfile(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<LawyerProfileBloc>(context).add(
        UpdateLawyerProfileEvent(
          licenseNumber: licenseController.text,
          specialization: specializationController.text,
          certificatePath: certificateFilePath, // null إذا ما تغيّرت
          address: addressController.text,
          age: ageController.text,
          experienceYears: expereinceYearsController.text,
          phone: phoneController.text,
          imagePath: _pickedImage?.path, // null إذا ما تغيّرت
        ),
      );
    }
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) =>
          value!.isEmpty ? 'This field cannot be empty' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _pickedImage != null
                          ? FileImage(_pickedImage!)
                          : (widget.lawyer.image.startsWith("http")
                              ? NetworkImage(widget.lawyer.image)
                              : const AssetImage(
                                  'assets/default_image.png')) as ImageProvider,
                      backgroundColor: Colors.grey[300],
                    ),
                    InkWell(
                      onTap: _pickImage,
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.camera_alt,
                            size: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField("Specialization", specializationController),
              const SizedBox(height: 15),
              _buildTextField("License Number", licenseController),
              const SizedBox(height: 15),
              _buildTextField("Age", ageController),
              const SizedBox(height: 15),
              _buildTextField("Address", addressController),
              const SizedBox(height: 15),
              _buildTextField("Phone", phoneController),
              const SizedBox(height: 15),
              _buildTextField("Expereince Years", expereinceYearsController),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: _pickCertificate,
                icon: const Icon(Icons.upload_file, color: Colors.white),
                label: const Text("Edit Certificate"),
                style: ElevatedButton.styleFrom(backgroundColor: customColor),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  certificateFilePath != null
                      ? "📎 File: ${basename(certificateFilePath!)}"
                      : "📎 File: ${basename(widget.lawyer.certificate)}",
                  style: const TextStyle(color: Color(0xFF8E6944)),
                ),
              ),
              const SizedBox(height: 30),
              BlocConsumer<LawyerProfileBloc, LawyerProfileState>(
                listener: (context, state) {
                  if (state is LawyerProfileSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.successmsg,
                          style: const TextStyle(fontSize: 16),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Future.delayed(const Duration(milliseconds: 300), () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => LawyerHomePage(),
                        ),
                        (route) => false,
                      );
                    });
                  } else if (state is LawyerProfileFail) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errmsg,
                          style: const TextStyle(fontSize: 16),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (state is LawyerProfileLoading) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Loading ...",
                          style: TextStyle(fontSize: 16),
                        ),
                        backgroundColor: Colors.grey,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () => _saveProfile(context),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: customColor),
                    child: const Text("Save Changes"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
