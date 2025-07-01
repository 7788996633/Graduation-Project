import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import '../../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../../widgets/custom_text_field.dart';
import '../../home/user_home_page.dart';

class CreateUserProfileScreen extends StatefulWidget {
  const CreateUserProfileScreen({super.key});

  @override
  State<CreateUserProfileScreen> createState() => _AddUserProfileScreenState();
}

class _AddUserProfileScreenState extends State<CreateUserProfileScreen> {
  final GlobalKey<FormState> myKey = GlobalKey<FormState>();

  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController scientificLevelController =
      TextEditingController();

  final Color mainColor = const Color(0xFF1E9AD8);

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
      appBar: AppBar(
        title: const Text("➕ Create Profile"),
        backgroundColor: mainColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: myKey,
          child: ListView(
            children: [
              CustomTextFeild(
                text: "Address",
                controller: addressController,
                validator: validateTextField,
                color: Colors.grey.shade300,
                icon: Icons.home,
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                text: "Phone",
                controller: phoneController,
                validator: validateTextField,
                color: Colors.grey.shade300,
                icon: Icons.phone,
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                text: "Age",
                controller: ageController,
                validator: validateTextField,
                color: Colors.grey.shade300,
                icon: Icons.cake,
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                text: "Scientific Level",
                controller: scientificLevelController,
                validator: validateTextField,
                color: Colors.grey.shade300,
                icon: Icons.school,
              ),
              const SizedBox(height: 20),

              // صورة البروفايل
              if (_pickedImage != null)
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: FileImage(_pickedImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 12),

              // زر اختيار الصورة
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image, color: Colors.black87),
                label: const Text(
                  "Pick Image",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              BlocConsumer<UserProfileBloc, UserProfileState>(
                listener: (context, state) {
                  if (state is UserProfileSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.successmsg,
                          style: const TextStyle(fontSize: 16),
                        ),
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
                        content: Text(
                          state.errmsg,
                          style: const TextStyle(fontSize: 16),
                        ),
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
                    icon: const Icon(Icons.person_add, color: Colors.black87),
                    label: const Text(
                      "Create",
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
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
