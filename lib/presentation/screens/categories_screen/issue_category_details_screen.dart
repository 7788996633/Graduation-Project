import 'package:flutter/material.dart';


import '../../../data/models/categories_model.dart';
import '../../../data/models/issues_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
class IssueCategoryDetailsScreen extends StatelessWidget {
  final CategoriesModel issueCategoryModel;

  const IssueCategoryDetailsScreen({super.key, required this.issueCategoryModel});

  @override
  Widget build(BuildContext context) {
    final category = issueCategoryModel;
    final List<IssuesModel> issues = category.issues;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomActionAppBar(title: 'تفاصيل التصنيف والقضايا'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // معلومات التصنيف
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اسم التصنيف: ${category.name}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'رقم التصنيف: ${category.id}',
                      style: const TextStyle(fontSize: 16, color: AppColors.darkBlue),
                    ),
                    if (category.parentId != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'رقم التصنيف الأب: ${category.parentId}', // ← هذا هو المطلوب
                        style: const TextStyle(fontSize: 16, color: AppColors.darkBlue),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // القضايا المرتبطة
            Text(
              'القضايا:',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 12),

            if (issues.isEmpty)
              const Text('لا توجد قضايا لهذا التصنيف'),
            ...issues.map((issue) => _buildIssueCard(issue)) ,
          ],
        ),
      ),
    );
  }

  Widget _buildIssueCard(IssuesModel issue) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              issue.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 6),
            Text('رقم القضية: ${issue.issueNumber}'),
            Text('الحالة: ${issue.status}'),
            Text('الأولوية: ${issue.priority}'),
            Text('المبلغ المدفوع: ${issue.amountPaid}'),
            Text('التكلفة الكلية: ${issue.totalCost}'),
            Text('اسم المحكمة: ${issue.courtName}'),
            Text('الخصم: ${issue.opponentName}'),
            Text('تاريخ البدء: ${issue.startDate}'),
            Text('تاريخ الانتهاء: ${issue.endDate}'),
          ],
        ),
      ),
    );
  }
}
