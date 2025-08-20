import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../blocs/legal_news_bloc/legal_news_event.dart';
import '../../data/models/legal_news_model.dart';
import '../../themes.dart';
import '../screens/legal_news_screen/legal_news_details_screen.dart';

class LegalNewsItem extends StatelessWidget {
  const LegalNewsItem({super.key, required this.legalNews});
  final LegalNewsModel legalNews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => LegalNewsBloc(),
                child: LegalNewsDetailsScreen(legalNews: legalNews),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صف الصورة والنص جنب بعض
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/grad.jpg',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Yagmoor Company',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // العنوان قبل الوصف
                Text(
                  legalNews.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
                const SizedBox(height: 8),

                // الوصف
                Text(
                  legalNews.description.length > 100
                      ? '${legalNews.description.substring(0, 100)}...'
                      : legalNews.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),

                // صف السهم وأيقونة الحذف
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        // إضافة حدث الحذف هنا
                        BlocProvider.of<LegalNewsBloc>(context).add(
                          DeleteLegalNewsEvent(legalNewsId: legalNews.id),
                        );
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.redAccent,
                        size: 24,
                      ),
                      tooltip: 'Delete News',
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_ios, size: 18, color: AppColors.darkBlue),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
