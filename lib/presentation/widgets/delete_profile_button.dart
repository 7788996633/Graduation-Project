import 'package:flutter/material.dart';

class DeleteProfileButton extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteProfileButton({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () => _showDeleteConfirmationDialog(context),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete your profile?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                onDelete();
                Navigator.of(dialogContext).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
