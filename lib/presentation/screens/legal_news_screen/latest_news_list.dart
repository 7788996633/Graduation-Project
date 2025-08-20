import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_event.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/refresh_button.dart';
import '../../widgets/latest_news_list.dart'; // تأكد استيراد الويجت الجديد

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'My News List',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LatestNewsList(bloc: bloc),  // تم التغيير هنا
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(MySavedLegalNewsEvent());
        },
      ),
    );
  }
}
