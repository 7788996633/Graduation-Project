import 'package:flutter/material.dart';
import '../../../data/models/legal_news_model.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../../themes.dart';

class LegalNewsDetailsScreen extends StatelessWidget {
  const LegalNewsDetailsScreen({super.key, required this.legalNews});
  final LegalNewsModel legalNews;

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
                      legalNews.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // وصف الخبر
                    Text(
                      legalNews.description,
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
      backgroundColor: Colors.grey.shade100, // خلفية هادئة
    );
  }
}
