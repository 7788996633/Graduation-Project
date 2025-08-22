import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_event.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/legal_news_list.dart';

import 'add_legal_news_screen.dart';
import 'my_saved_news_list.dart';

class ListLegalNewsScreen extends StatefulWidget {
  const ListLegalNewsScreen({super.key});

  @override
  State<ListLegalNewsScreen> createState() => _ListLegalNewsScreenState();
}

class _ListLegalNewsScreenState extends State<ListLegalNewsScreen> {
  late LegalNewsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<LegalNewsBloc>(context);
    bloc.add(GetAllLegalNewsEvent());
  }

  Future<void> _onRefresh() async {
    bloc.add(GetAllLegalNewsEvent());
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Legal News',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Legal News',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => LegalNewsBloc(),
                child: const AddLegalNewsScreen(),
              ),
            ),
          );
        },
        secondaryIcon: Icons.bookmark,
        secondaryTooltip: 'My Saved News',
        onSecondaryPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => LegalNewsBloc(),
                child: const MyNewsListScreen(),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: LegalNewsList(bloc: bloc),
        ),
      ),
    );
  }
}
