import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/issue_bloc/issues_bloc.dart';
import '../../data/models/categories_model.dart';
import '../screens/categories_screen/issue_category_details_screen.dart';

class IssueCategoryItem extends StatelessWidget {
  final CategoriesModel issueCategoryModel;

  const IssueCategoryItem({super.key, required this.issueCategoryModel});

  @override
  Widget build(BuildContext context) {
    return _buildCategory(context, issueCategoryModel, 0);
  }

  Color _getColorByDepth(int depth) {
    const shades = [
      Color(0xFFCFD8DC), // Grey 100
      Color(0xFFB0BEC5), // Grey 200
      Color(0xFF90A4AE), // Grey 300
      Color(0xFF78909C), // Grey 400
      Color(0xFF607D8B), // Grey 500
    ];

    if (depth >= shades.length) {
      return shades.last;
    }
    return shades[depth];
  }

  Widget _buildCategory(
      BuildContext context, CategoriesModel category, int depth) {
    return Card(
      color: _getColorByDepth(depth),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 3,
      child: ListTile(
        title: Text(category.name),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => IssuesBloc(),
                child: IssueCategoryDetailsScreen(issueCategoryModel: category),
              ),
            ),
          );
        },
      ),
    );
  }
}
