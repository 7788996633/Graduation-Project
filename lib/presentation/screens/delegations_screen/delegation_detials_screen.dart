import 'package:flutter/material.dart';
import '../../../data/models/delegations_model.dart';
import '../../widgets/custom_appbar_add.dart';

class DelegationDetailsScreen extends StatelessWidget {
  const DelegationDetailsScreen({super.key, required this.delegation});
  final DelegationModel delegation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomActionAppBar(
        title: 'Delegation Details',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoText('ID', delegation.id.toString()),
            _infoText('Status', delegation.status ?? '-'),
            _infoText('Admin Note', delegation.adminNote ?? '-'),
            _infoText('Session ID', delegation.sessionId.toString()),
            _infoText('Original Lawyer ID', delegation.originalLawyerId.toString()),
            _infoText('Delegate Lawyer ID', delegation.delegateLawyerId.toString()),
            _infoText('Delegation File', delegation.delegationFile ?? '-'),
            const SizedBox(height: 30),
            if (delegation.delegationFile != null && delegation.delegationFile!.isNotEmpty) ...[
              Text(
                'Attached File',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade700,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ImageFullScreen(url: delegation.delegationFile!),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    delegation.delegationFile!,
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 250,
                      alignment: Alignment.center,
                      child: const Text(
                        'Failed to load file',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ] else
              Text(
                'No attached file',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _infoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.deepPurple.shade700,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              ),
            ),
          ],
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
        backgroundColor: Colors.black,
        title: const Text('View Image'),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(url),
        ),
      ),
    );
  }
}
