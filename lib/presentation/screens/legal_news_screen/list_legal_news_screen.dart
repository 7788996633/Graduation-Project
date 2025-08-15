import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_event.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/legal_news_list.dart';
import '../../widgets/refresh_button.dart';
import '../../widgets/custom_search_bar.dart';  // إضافة ويدجت البحث


import 'add_legal_news_screen.dart';  // شاشة إضافة خبر قانوني

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            LegalNewsList(bloc: bloc),

      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllLegalNewsEvent());
        },
      ),
    );
  }
}
