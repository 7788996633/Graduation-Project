import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/required_document_bloc/required_document_bloc.dart';
import '../../blocs/required_document_bloc/required_document_event.dart';
import '../../data/models/required_document_model.dart';
import '../../themes.dart';
import '../screens/required_documents/required_document_detials.dart';

class RequiredDocumentItem extends StatelessWidget {
  const RequiredDocumentItem({super.key, required this.requiredDocument});
  final RequiredDocumentModel requiredDocument;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RequiredDocumentDetailsScreen(
              requiredDocument: requiredDocument,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: AppColors.darkBlue, // ✅ تم تغيير اللون للأزرق الغامق
            width: 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon with soft background
            Container(
              decoration: BoxDecoration(
                color: AppColors.darkBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.description_outlined,
                color: AppColors.darkBlue,
                size: 28,
              ),
            ),

            const SizedBox(width: 16),

            // Text info section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    requiredDocument.requireFileType,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.verified, size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        'Status: ${requiredDocument.status}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),

            // Delete button
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 22),
              onPressed: () {
                BlocProvider.of<RequiredDocumentsBloc>(context).add(
                  DeleteRequiredDocumentsEvent(requiredDocumentId: requiredDocument.id),
                );
              },
              tooltip: 'Delete',
            ),
          ],
        ),
      ),
    );
  }
}
