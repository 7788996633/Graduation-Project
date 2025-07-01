import 'package:flutter/material.dart';

class CustomListCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final String deleteDialogTitle;
  final String deleteDialogContent;
  final String deleteSuccessMessage;

  const CustomListCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.onDelete,
    this.deleteDialogTitle = "Delete Item",
    this.deleteDialogContent = "Are you sure you want to delete this item?",
    this.deleteSuccessMessage = "Deleted successfully",
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(deleteDialogTitle),
                content: Text(deleteDialogContent),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onDelete();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(deleteSuccessMessage),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child:
                    const Text("Delete", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
