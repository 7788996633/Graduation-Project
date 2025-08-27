import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_event.dart';
import '../../../blocs/legal_news_bloc/legal_news_state.dart';
import '../../../constant.dart';
import '../../../data/models/legal_news_model.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/legal_news_item.dart';

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
        actionIcon: (myRole != null && myRole.toLowerCase() == 'admin')
            ? Icons.add_circle_rounded
            : null,
        tooltip: 'Add New Legal News',
        onActionPressed: () {
          if (myRole != null && myRole.toLowerCase() == 'admin') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => LegalNewsBloc(),
                  child: const AddLegalNewsScreen(),
                ),
              ),
            );
          }
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
          child: BlocBuilder<LegalNewsBloc, LegalNewsState>(
            builder: (context, state) {
              if (state is LegalNewsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LegalNewsFail) {
                // حتى الخطأ بدنا نخليه يقدر يعمل Refresh
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(state.errMsg),
                      ),
                    ),
                  ],
                );
              } else if (state is LegalNewsListLoaded) {
                final List<LegalNewsModel> newsList = state.list;
                if (newsList.isEmpty) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('No Legal News Available'),
                        ),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    return LegalNewsItem(legalNews: newsList[index]);
                  },
                );
              }
              // الحالة المبدئية: نخليها قابلة للسحب كمان
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
              );
            },
          ),
        ),
      ),
    );
  }
}
