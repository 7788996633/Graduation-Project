import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/legal_book_model.dart';
import '../../../themes.dart';

class LegalBookDetailsScreen extends StatefulWidget {
  final LegalBookModel legalBook;

  const LegalBookDetailsScreen({super.key, required this.legalBook});

  @override
  State<LegalBookDetailsScreen> createState() => _LegalBookDetailsScreenState();
}

class _LegalBookDetailsScreenState extends State<LegalBookDetailsScreen> {
  bool _loading = false;
  Map<String, dynamic>? _bookData;
  String? _error;

  @override
  void initState() {
    super.initState();
    _openBook(); // استدعاء الكتاب مباشرة عند فتح الشاشة
  }

  Future<void> _openBook() async {
    setState(() {
      _loading = true;
      _error = null;
      _bookData = null;
    });

    try {
      final data = {
        'عنوان الكتاب': widget.legalBook.bookTitle,
        'رابط الكتاب': widget.legalBook.book,
        'تاريخ الإنشاء': widget.legalBook.createdAt,
        'آخر تعديل': widget.legalBook.updatedAt,
      };

      final pdfLink = widget.legalBook.book;
      if (pdfLink.isNotEmpty) {
        final uri = Uri.parse(prepareFullUrl(pdfLink));
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('لا يمكن فتح الرابط')),
          );
        }
      }

      setState(() {
        _bookData = data;
      });
    } catch (e) {
      setState(() {
        _error = 'حدث خطأ أثناء تحميل الكتاب: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  String prepareFullUrl(String value) {
    const String baseUrl = 'http://127.0.0.1:8000/storage/LawCompany/public/';
    return value.startsWith('http') ? value : '$baseUrl$value';
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
                final uri = Uri.parse(prepareFullUrl(value));
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri,
                      mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('لا يمكن فتح الرابط')),
                  );
                }
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
    if (_bookData == null) return const SizedBox.shrink();

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
                Icons.menu_book_rounded,
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
            ..._bookData!.entries.map((entry) {
              return _buildInfoRow(
                icon: Icons.info_outline,
                label: entry.key,
                value: entry.value?.toString() ?? '',
                isLink: (entry.value?.toString().contains('.pdf') ?? false) ||
                    (entry.value?.toString().startsWith('http') ?? false),
              );
            }).toList(),
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
        title: const Text('تفاصيل الكتاب القانوني'),
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
