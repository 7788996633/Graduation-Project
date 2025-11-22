import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/required_document_bloc/required_document_bloc.dart';
import 'package:graduation/blocs/required_document_bloc/required_document_event.dart';
import 'package:graduation/constant.dart';
import 'package:graduation/presentation/screens/required_documents/upload_required_documents.dart';
import '../../../data/models/required_document_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class RequiredDocumentDetailsScreen extends StatelessWidget {
  const RequiredDocumentDetailsScreen(
      {super.key, required this.requiredDocument});
  final RequiredDocumentModel requiredDocument;

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.darkBlue),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(color: Colors.black87)),
                  TextSpan(
                      text: value,
                      style: const TextStyle(color: AppColors.darkBlue)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: getCurrentTheme()['AppBar'],
        title: Text(
          ' ',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          if (myRole == 'user')
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => RequiredDocumentsBloc(),
                      child: UploadDocumentScreen(
                          issueId: requiredDocument.issueId),
                    ),
                  ));
                },
                icon: Icon(Icons.upload_file))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 12,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Icon(Icons.insert_drive_file_rounded,
                          size: 60, color: AppColors.darkBlue),
                      const SizedBox(height: 10),
                      const Text(
                        'Document Info',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                _buildInfoRow(Icons.file_present, 'Type',
                    requiredDocument.requireFileType),
                const Divider(),
                _buildInfoRow(
                    Icons.verified, 'Status', requiredDocument.status),
                const Divider(),
                _buildInfoRow(
                    Icons.notes, 'Note', requiredDocument.note ?? 'No note'),
                const SizedBox(height: 30),
                const Text(
                  'Attached File',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                if (requiredDocument.file != null &&
                    requiredDocument.file!.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ImageFullScreen(url: requiredDocument.file!),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Hero(
                        tag: 'doc_image',
                        child: Image.network(
                          requiredDocument.file!,
                          fit: BoxFit.cover,
                          height: 250,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 250,
                            alignment: Alignment.center,
                            color: Colors.grey.shade200,
                            child: const Text(
                              '⚠️ Failed to load file',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  Text(
                    'No attached file.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageFullScreen extends StatelessWidget {
  final String url;
  const ImageFullScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('View Image', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Hero(
          tag: 'doc_image',
          child: InteractiveViewer(
            child: Image.network(url),
          ),
        ),
      ),
    );
  }
}
