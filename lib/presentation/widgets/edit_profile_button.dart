import 'package:flutter/material.dart';

class EditProfileButton extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onTap;

  const EditProfileButton({
    super.key,
    required this.isEditing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isEditing ? Icons.save : Icons.edit),
      onPressed: onTap,
    );
  }
}
