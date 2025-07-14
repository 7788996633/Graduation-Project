import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/categories/categories_bloc.dart';
import '../../../blocs/categories/categories_event.dart';

import '../../../data/models/categories_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class IssueCategoryDetailsScreen extends StatefulWidget {
  final CategoriesModel issueCategoryModel;

  const IssueCategoryDetailsScreen({super.key, required this.issueCategoryModel});

  @override
  State<IssueCategoryDetailsScreen> createState() => _IssueCategoryDetailsScreenState();
}

class _IssueCategoryDetailsScreenState extends State<IssueCategoryDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // استدعاء التصنيف بحسب ID
    BlocProvider.of<CategoriesBloc>(context).add(
      GetCategoriesByIdEvent(categoryId: widget.issueCategoryModel.id),
    );
  }

  // دالة لتنسيق عرض التفاصيل
  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: valueColor ?? Colors.black87,
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
      backgroundColor: Colors.deepPurple.shade50,
      appBar: const CustomActionAppBar(
        title: 'Issue Category Details',
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoriesLoaded) {
            final category = state.category;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 12,
                shadowColor: Colors.deepPurple.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.category_outlined,
                          size: 80,
                          color: AppColors.darkBlue,
                          shadows: [
                            Shadow(
                              color: Colors.blueAccent.shade200.withOpacity(0.6),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoRow('ID', category.id.toString()),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Name', category.name),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Type', category.type ?? '—'),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Parent ID', category.parentId?.toString() ?? '—'),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is CategoriesFail) {
            return Center(
              child: Text(
                'Error: ${state.errMsg}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
