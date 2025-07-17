import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/issue_bloc/issues_bloc.dart';
import 'package:graduation/presentation/widgets/isssues_category_list.dart';
import 'package:graduation/presentation/widgets/user_issue_item.dart';

import '../../../data/models/categories_model.dart';
import '../../../data/models/issues_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class IssueCategoryDetailsScreen extends StatefulWidget {
  final CategoriesModel issueCategoryModel;

  const IssueCategoryDetailsScreen(
      {super.key, required this.issueCategoryModel});

  @override
  State<IssueCategoryDetailsScreen> createState() =>
      _IssueCategoryDetailsScreenState();
}

class _IssueCategoryDetailsScreenState
    extends State<IssueCategoryDetailsScreen> {
  bool isLeaf = false;
  late IssuesBloc issuesBloc;

  @override
  void initState() {
    isLeaf = (widget.issueCategoryModel.children.isEmpty);
    if (isLeaf) {
      issuesBloc = BlocProvider.of<IssuesBloc>(context);
      issuesBloc.add(
        GetIssuesByCategoryId(
          categoryId: widget.issueCategoryModel.id,
        ),
      );
    }
    print(widget.issueCategoryModel.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<IssuesModel> issues = [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomActionAppBar(
        title: widget.issueCategoryModel.name,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLeaf)
              Column(
                children: [
                  Text(
                    'القضايا:',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  BlocBuilder<IssuesBloc, IssuesState>(
                    builder: (context, state) {
                      if (state is IssuesListLoadedSuccessFully) {
                        issues = state.issues;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: issues.length,
                          itemBuilder: (context, index) => UserIssueItem(
                            issuesModel: issues[index],
                            issuesBloc: issuesBloc,
                          ),
                        );
                      } else if (state is IssuesFail) {
                        return Text(
                          state.errmsg,
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              )
            else
              IsssuesCategoryList(
                categoriesModel: widget.issueCategoryModel.children,
              ),
          ],
        ),
      ),
    );
  }
}
