import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../data/models/legal_news_model.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../../themes.dart';
import 'update_legal_news.dart';


class LegalNewsDetailsScreen extends StatefulWidget {
  const LegalNewsDetailsScreen({super.key, required this.legalNews});
  final LegalNewsModel legalNews;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomActionAppBar(
        title: 'Legal News Details',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // البطاقة الرئيسية
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان
                    Text(
                      news.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // وصف الخبر
                    Text(
                      news.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // أي معلومات إضافية يمكن وضعها هنا
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Icons.article, color: AppColors.darkBlue, size: 28),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // فتح شاشة تعديل الخبر
          final result = await Navigator.push<LegalNewsModel>(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (_) => LegalNewsBloc(), // ضع هنا البلوك المناسب إذا أردت
                child: UpdateLegalNewsScreen(legalNews: news),
              ),
            ),
          );

          if (result != null) {
            refreshData(result);
          }
        },
        icon: const Icon(Icons.edit),
        label: const Text(
          'Edit',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.darkBlue,
        elevation: 6,
        hoverElevation: 12,
        extendedPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
