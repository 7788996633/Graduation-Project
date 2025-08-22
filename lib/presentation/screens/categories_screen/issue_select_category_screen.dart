import 'package:flutter/material.dart';

import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../data/models/categories_model.dart';
import '../../widgets/custom_appbar_add.dart';

class IssueSelectCategoryScreen extends StatefulWidget {
  final CategoriesModel issueCategoryModel;
  late CategoriesModel selectedCategory;
  late Function? onselect;
  IssueSelectCategoryScreen({
    super.key,
    required this.issueCategoryModel,
    required this.selectedCategory,
  });

  @override
  State<IssueSelectCategoryScreen> createState() =>
      _IssueSelectCategoryScreenState();
}

class _IssueSelectCategoryScreenState extends State<IssueSelectCategoryScreen> {
  bool isLeaf = false;
  late IssuesBloc issuesBloc;

  @override
  void initState() {
    isLeaf = (widget.issueCategoryModel.children.isEmpty);
    if (isLeaf) {
      widget.selectedCategory = widget.issueCategoryModel;
    }
    print(widget.issueCategoryModel.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                  "You have selceted ${widget.issueCategoryModel.name} for your issue")
            else
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                shrinkWrap: true,
                itemCount: widget.issueCategoryModel.children.length,
                itemBuilder: (context, index) {
                  int selectedindex = -1;

                  return GestureDetector(
                    onTap: () {
                      if (widget.issueCategoryModel.children[index].children
                          .isNotEmpty) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => IssueSelectCategoryScreen(
                            issueCategoryModel:
                                widget.issueCategoryModel.children[index],
                            selectedCategory: widget.selectedCategory,
                          ),
                        ));
                      } else {
                        selectedindex = index;

                        setState(() {});
                        print("selectedindex $selectedindex ");
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
                          widget.issueCategoryModel.children[index].name,
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
              ),
          ],
        ),
      ),
    );
  }
}
