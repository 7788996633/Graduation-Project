import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_event.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/my_news_list.dart';

class MyNewsListScreen extends StatefulWidget {
  const MyNewsListScreen({super.key});

  @override
  State<MyNewsListScreen> createState() => _MyNewsListScreenState();
}

class _MyNewsListScreenState extends State<MyNewsListScreen> {
  late LegalNewsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<LegalNewsBloc>(context);
    bloc.add(MySavedLegalNewsEvent());
  }

  Future<void> _onRefresh() async {
    bloc.add(MySavedLegalNewsEvent());
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: const CustomActionAppBar(
        title: 'My News List',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: MyNewsList(bloc: bloc),
          ),
        ),
      ),
    );
  }
}
