import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_text_field.dart';
import '../../home/user_home_page.dart';

class CreateUserProfileScreen extends StatefulWidget {
  const CreateUserProfileScreen({super.key});

  @override
  State<CreateUserProfileScreen> createState() =>
      _CreateUserProfileScreenState();
}

class _CreateUserProfileScreenState extends State<CreateUserProfileScreen> {
  final GlobalKey<FormState> myKey = GlobalKey<FormState>();

  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController scientificLevelController =
  TextEditingController();

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    ageController.dispose();
    addressController.dispose();
    phoneController.dispose();
    scientificLevelController.dispose();
    super.dispose();
  }

  String? validateTextField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        title: const Text("Create User Profile",
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: myKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),

              // صورة البروفايل
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.darkBlue.withOpacity(0.2),
                        backgroundImage: _pickedImage != null
                            ? FileImage(_pickedImage!)
                            : null,
                        child: _pickedImage == null
                            ? const Icon(Icons.camera_alt,
                            size: 30, color: Colors.white)
                            : null,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              CustomTextFeild(
                text: "Address",
                controller: addressController,
                validator: validateTextField,
                color: Colors.grey.shade200,
                icon: Icons.home,
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                text: "Phone",
                controller: phoneController,
                validator: validateTextField,
                color: Colors.grey.shade200,
                icon: Icons.phone,
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                text: "Age",
                controller: ageController,
                validator: validateTextField,
                color: Colors.grey.shade200,
                icon: Icons.cake,
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                text: "Scientific Level",
                controller: scientificLevelController,
                validator: validateTextField,
                color: Colors.grey.shade200,
                icon: Icons.school,
              ),
              const SizedBox(height: 25),

              BlocConsumer<UserProfileBloc, UserProfileState>(
                listener: (context, state) {
                  if (state is UserProfileSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.successmsg,
                            style: const TextStyle(fontSize: 16)),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const UserHomePage(),
                      ),
                    );
                  } else if (state is UserProfileFail) {
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
                  return ElevatedButton.icon(
                    onPressed: () {
                      if (myKey.currentState!.validate()) {
                        if (_pickedImage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please pick an image first"),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          return;
                        }

                        BlocProvider.of<UserProfileBloc>(context).add(
                          CreateUserProfileEvent(
                            phone: phoneController.text,
                            address: addressController.text,
                            age: ageController.text,
                            scientificLevel: scientificLevelController.text,
                            imagePath: _pickedImage!.path,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.person_add, color: Colors.white),
                    label: const Text(
                      "Create Profile",
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
            ],
          ),
        ),
      ),
    );
  }
}
