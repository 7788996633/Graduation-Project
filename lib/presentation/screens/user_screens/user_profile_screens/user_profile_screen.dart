import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../../../constant.dart';
import '../../../../data/models/user_profile_model.dart';
import '../../../widgets/delete_profile_button.dart';
import '../../../widgets/edit_profile_button.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, required this.userProfileModel});
  final UserProfileModel userProfileModel;
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController ageController;
  late TextEditingController scientificLevelController;
  bool isEditing = false;

  late final UserProfileBloc bloc;
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<UserProfileBloc>(context);
    nameController = TextEditingController(text: widget.userProfileModel.name);
    emailController =
        TextEditingController(text: widget.userProfileModel.email);
    phoneController =
        TextEditingController(text: widget.userProfileModel.phone);
    addressController =
        TextEditingController(text: widget.userProfileModel.address);
    ageController =
        TextEditingController(text: widget.userProfileModel.age.toString());
    scientificLevelController =
        TextEditingController(text: widget.userProfileModel.scientificLevel);
  }

  @override
  Widget build(BuildContext context) {
    final bool isMyProfile = widget.userProfileModel.userId == myUserId;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        actions: [
          if (isMyProfile)
            EditProfileButton(
              isEditing: isEditing,
              onTap: () {
                setState(() {
                  if (isEditing) {
                    bloc.add(UpdateUserProfileEvent(
                      phone: phoneController.text,
                      address: addressController.text,
                      age: ageController.text,
                      scientificLevel: scientificLevelController.text,
                      imagePath:
                          _pickedImage?.path ?? widget.userProfileModel.image,
                    ));
                    bloc.add(ShowUserProfileEvent());
                  }
                  isEditing = !isEditing;
                });
              },
            ),
          if (isMyProfile)
            DeleteProfileButton(
              onDelete: () {
                bloc.add(
                  DeleteUserProfileEvent(),
                );
              },
            ),
        ],
      ),
      body: _buildProfileContent(isMyProfile),
    );
  }

  Widget _buildProfileContent(bool isMyProfile) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _pickedImage != null
                          ? FileImage(_pickedImage!)
                          : NetworkImage(widget.userProfileModel.image),
                      backgroundColor: Colors.grey[300],
                    ),
                    if (isEditing && isMyProfile)
                      Positioned(
                        child: InkWell(
                          onTap: _pickImage,
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.camera_alt,
                                size: 20, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  widget.userProfileModel.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const Divider(height: 30, thickness: 1.2),
                _buildInfoRow(Icons.email, "Email", emailController, false),
                _buildInfoRow(Icons.phone, "Phone", phoneController,
                    isEditing && isMyProfile),
                _buildInfoRow(Icons.location_on, "Address", addressController,
                    isEditing && isMyProfile),
                _buildInfoRow(
                    Icons.cake, "Age", ageController, isEditing && isMyProfile),
                _buildInfoRow(Icons.school, "Scientific Level",
                    scientificLevelController, isEditing && isMyProfile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorContent(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Error occurred:",
            style: TextStyle(
                fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            errorMessage,
            style: const TextStyle(fontSize: 20, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label,
      TextEditingController controller, bool editable) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87),
                ),
                const SizedBox(height: 5),
                editable
                    ? TextFormField(
                        controller: controller,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                        decoration: const InputDecoration(
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      )
                    : Text(
                        controller.text,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _pickedImage = File(result.files.single.path!);
      });
    }
  }
}
