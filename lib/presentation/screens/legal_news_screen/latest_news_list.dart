import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_event.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/latest_news_list.dart';

class LatestNewsListScreen extends StatefulWidget {
  const LatestNewsListScreen({super.key});

  @override
  State<LatestNewsListScreen> createState() => _LatestNewsListScreenState();
}

class _LatestNewsListScreenState extends State<LatestNewsListScreen> {
  late LegalNewsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<LegalNewsBloc>(context);
    _bloc.add(LegalNewsLatestEvent());
  }

  Future<void> _onRefresh() async {
    _bloc.add(LegalNewsLatestEvent());
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: const CustomActionAppBar(
        title: 'Latest News',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: LatestNewsList(bloc: _bloc),
        ),
      ),
    );
  }
}
