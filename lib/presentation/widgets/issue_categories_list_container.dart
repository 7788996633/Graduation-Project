import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/categories/categories_bloc.dart';
import '../../blocs/categories/categories_event.dart';

import '../../data/models/categories_model.dart';
import 'isssues_category_list.dart';

class IssueCategoryListContainer extends StatefulWidget {
  const IssueCategoryListContainer({super.key, required this.bloc});
  final CategoriesBloc bloc;

  @override
  State<IssueCategoryListContainer> createState() => _IssueCategoryListState();
}

class _IssueCategoryListState extends State<IssueCategoryListContainer> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllCategoriesEvent());
  }

  List<CategoriesModel> issueCategoryList = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoriesBloc, CategoriesState>(
      listener: (context, state) {
        if (state is CategoriesSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllCategoriesEvent());
        } else if (state is CategoriesFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesListLoaded) {
            issueCategoryList = state.list;
            if (issueCategoryList.isEmpty) {
              return const Center(child: Text('There are no issue categories'));
            }
            return Expanded(
              child: IsssuesCategoryList(
                categoriesModel: issueCategoryList,
              ),
            );
          } else if (state is CategoriesFail) {
            return Column(
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.errMsg,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
