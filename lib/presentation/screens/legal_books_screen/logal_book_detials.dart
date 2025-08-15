import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart' as kisweb;

import '../../../data/models/legal_book_model.dart';
import '../../../themes.dart';

class LegalBookDetailsScreen extends StatefulWidget {
  const LegalBookDetailsScreen({super.key, required this.legalBook});
  final LegalBookModel legalBook;

  @override
  State<LegalBookDetailsScreen> createState() => _LegalBookDetailsScreenState();
}

class _LegalBookDetailsScreenState extends State<LegalBookDetailsScreen> {
  bool _loading = false;
  String? _error;

  String prepareFullUrl(String value) {
    const String baseUrl = 'http://192.168.1.10/LawCompany/public/';
    if (value.startsWith('http')) {
      return value;
    } else {
      return '$baseUrl$value';
    }
  }

  Future<void> _openFile(String fileUrl) async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final url = prepareFullUrl(fileUrl);
      if (kIsWeb) {
        kisweb.launch(url);
      } else {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          setState(() {
            _error = 'لا يمكن فتح الملف';
          });
        }
      }
    } catch (e) {
      setState(() {
        _error = 'حدث خطأ: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool isLink = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.darkBlue, size: 22),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: isLink
                ? GestureDetector(
              onTap: () async {
                if (value.isEmpty) return;
                await _openFile(value);
              },
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.darkBlue,
                  decoration: TextDecoration.underline,
                  height: 1.3,
                ),
              ),
            )
                : Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard() {
    final book = widget.legalBook;
    if ((book.book ?? '').isEmpty) return const SizedBox.shrink();

    return Card(
      elevation: 8,
      margin: const EdgeInsets.only(top: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.insert_drive_file,
                size: 72,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'تفاصيل الكتاب القانوني',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
            ),
            const Divider(height: 30, thickness: 1.2),
            _buildInfoRow(
              icon: Icons.label,
              label: 'ID',
              value: book.id.toString(),
            ),
            _buildInfoRow(
              icon: Icons.book,
              label: 'Book Title',
              value: book.bookTitle,
            ),
            _buildInfoRow(
              icon: Icons.link,
              label: 'Attached File',
              value: book.book ?? '',
              isLink: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    if (_error == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        _error!,
        style: const TextStyle(color: Colors.red, fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legal Book Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_loading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            _buildBookCard(),
            _buildError(),
          ],
        ),
      ),
    );
  }
}
