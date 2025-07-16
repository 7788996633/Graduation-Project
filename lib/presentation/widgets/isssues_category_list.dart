import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/data/models/categories_model.dart';
import 'package:graduation/themes.dart';

import '../../blocs/issue_bloc/issues_bloc.dart';
import '../screens/categories_screen/issue_category_details_screen.dart';

class IsssuesCategoryList extends StatelessWidget {
  const IsssuesCategoryList({super.key, required this.categoriesModel});
  final List<CategoriesModel> categoriesModel;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => IssuesBloc(),
                child: IssueCategoryDetailsScreen(
                  issueCategoryModel: categoriesModel[index],
                ),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              25,
            ),
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              categoriesModel[index].name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      itemCount: categoriesModel.length,
    );
  }
}
