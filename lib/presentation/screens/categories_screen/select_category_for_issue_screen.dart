import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/categories/categories_bloc.dart';
import '../../../blocs/categories/categories_event.dart';

import '../../../data/models/categories_model.dart';
import '../../../themes.dart';

import '../../widgets/custom_appbar_add.dart';
import '../../widgets/refresh_button.dart';
import 'issue_select_category_screen.dart';

class SelectCategoryForIssueScreen extends StatefulWidget {
  SelectCategoryForIssueScreen({
    super.key,
    required this.selectedCategory,
  });
  late CategoriesModel selectedCategory;
  late Function? onSelect;
  @override
  State<SelectCategoryForIssueScreen> createState() =>
      _SelectCategoryForIssueScreenState();
}

class _SelectCategoryForIssueScreenState
    extends State<SelectCategoryForIssueScreen> {
  late CategoriesBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CategoriesBloc>(context);
    bloc.add(GetAllCategoriesEvent());
  }

  List<CategoriesModel> categories = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomActionAppBar(
        title: 'Select Category',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesListLoaded) {
                  categories = state.list;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      int selectedindex = -1;

                      return GestureDetector(
                        onTap: () {
                          if (categories[index].children.isNotEmpty) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => IssueSelectCategoryScreen(
                                issueCategoryModel: categories[index],
                                selectedCategory: widget.selectedCategory,
                              ),
                            ));
                          } else {
                            selectedindex = index;

                            setState(() {});
                           }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                            border: Border.all(
                              color: selectedindex == index
                                  ? Colors.blue
                                  : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              categories[index].name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is CategoriesFail) {
                  return Text(state.errMsg);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllCategoriesEvent());
        },
      ),
    );
  }
}
