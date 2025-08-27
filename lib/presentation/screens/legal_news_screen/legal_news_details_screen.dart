import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../data/models/legal_news_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import 'update_legal_news.dart';

class LegalNewsDetailsScreen extends StatefulWidget {
  final LegalNewsModel legalNews;

  const LegalNewsDetailsScreen({super.key, required this.legalNews});

  @override
  State<LegalNewsDetailsScreen> createState() => _LegalNewsDetailsScreenState();
}

class _LegalNewsDetailsScreenState extends State<LegalNewsDetailsScreen> {
  late LegalNewsModel news;

  @override
  void initState() {
    super.initState();
    news = widget.legalNews;
  }

  void refreshData(LegalNewsModel updated) {
    setState(() {
      news = updated;
    });
  }

  String prepareFullUrl(String value) {
    const String baseUrl = 'http://192.168.1.10/LawCompany/public/';
    if (value.startsWith('http')) {
      return value;
    } else {
      return '$baseUrl$value';
    }
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
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not open URL')),
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
      appBar: const CustomActionAppBar(title: 'Legal News Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 10,
          color: Colors.white,
          shadowColor: Colors.blueGrey.shade100,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(Icons.article, size: 72, color: AppColors.darkBlue),
                ),
                const SizedBox(height: 20),
                _buildInfoRow(
                  icon: Icons.title,
                  label: 'Title',
                  value: news.title,
                ),
                _buildInfoRow(
                  icon: Icons.description_outlined,
                  label: 'Description',
                  value: news.description,
                ),
                // إضافة أي معلومات إضافية هنا إذا رغبت
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final updatedNews = await Navigator.push<LegalNewsModel>(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => LegalNewsBloc(),
                child: UpdateLegalNewsScreen(legalNews: news),
              ),
            ),
          );

          if (updatedNews != null) {
            refreshData(updatedNews);
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
