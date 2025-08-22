import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/categories/categories_bloc.dart';
import '../../../blocs/categories/categories_event.dart';

import '../../../themes.dart';

import '../../widgets/custom_appbar_add.dart';
import '../../widgets/issue_categories_list_container.dart';
import '../../widgets/refresh_button.dart';

class ListIssueCategoriesScreen extends StatefulWidget {
  const ListIssueCategoriesScreen({super.key});

  @override
  State<ListIssueCategoriesScreen> createState() =>
      _ListIssueCategoriesScreenState();
}

class _ListIssueCategoriesScreenState extends State<ListIssueCategoriesScreen> {
  late CategoriesBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CategoriesBloc>(context);
    bloc.add(GetAllCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],
      appBar: CustomActionAppBar(
        title: 'Issue Categories',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            IssueCategoryListContainer(bloc: bloc),
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