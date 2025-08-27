import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../blocs/legal_books_bloc/legal_books_bloc.dart';
import '../../../data/models/legal_book_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import 'update_logal_book.dart';

class LegalBookDetailsScreen extends StatefulWidget {
  final LegalBookModel legalBook;

  const LegalBookDetailsScreen({super.key, required this.legalBook});

  @override
  State<LegalBookDetailsScreen> createState() =>
      _LegalBookDetailsScreenState();
}

class _LegalBookDetailsScreenState extends State<LegalBookDetailsScreen> {
  late LegalBookModel book;

  @override
  void initState() {
    super.initState();
    book = widget.legalBook;
  }

  void refreshData(LegalBookModel updated) {
    setState(() {
      book = updated;
    });
  }

  String prepareFullUrl(String value) {
    const String baseUrl = 'http://192.168.137.130/LawCompany/public/';
    if (value.startsWith('http')) return value;
    return '$baseUrl$value';
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool isLink = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
                    const SnackBar(
                        content: Text('❌ Could not open URL')),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: const CustomActionAppBar(title: 'Legal Book Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 10,
          color: Colors.white,
          shadowColor: Colors.blueGrey.shade100,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
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
                _buildInfoRow(
                  icon: Icons.badge_outlined,
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
                  isLink: (book.book ?? '').isNotEmpty,
                ),
                _buildInfoRow(
                  icon: Icons.date_range_outlined,
                  label: 'Created At',
                  value: book.createdAt,
                ),
                _buildInfoRow(
                  icon: Icons.update,
                  label: 'Updated At',
                  value: book.updatedAt,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final updatedBook = await Navigator.push<LegalBookModel>(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => LegalBookBloc(),
                child: UpdateLegalBookScreen(legalBook: book),
              ),
            ),
          );
          if (updatedBook != null) {
            refreshData(updatedBook);
          }
        },
        icon: const Icon(Icons.edit, color: Colors.white),
        label: const Text(
          'Edit',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: AppColors.darkBlue,
      ),
    );
  }
}
