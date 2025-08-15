import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../blocs/legal_news_bloc/legal_news_event.dart';
import '../../blocs/legal_news_bloc/legal_news_state.dart';

import '../../data/models/legal_news_model.dart';
import 'legal_news_item.dart';  // لازم تنشئ هذا الwidget مشابه لـ LegalBookItem

class LegalNewsList extends StatefulWidget {
  const LegalNewsList({super.key, required this.bloc});
  final LegalNewsBloc bloc;

  @override
  State<LegalNewsList> createState() => _LegalNewsListState();
}

class _LegalNewsListState extends State<LegalNewsList> {
  List<LegalNewsModel> legalNewsList = [];

  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllLegalNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LegalNewsBloc, LegalNewsState>(
      listener: (context, state) {
        if (state is LegalNewsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllLegalNewsEvent());
        } else if (state is LegalNewsFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LegalNewsBloc, LegalNewsState>(
        builder: (context, state) {
          if (state is LegalNewsListLoaded) {
            legalNewsList = state.list;
            if (legalNewsList.isEmpty) {
              return const Center(child: Text('There are no legal news.'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: legalNewsList.length,
                itemBuilder: (context, index) {
                  return LegalNewsItem(
                    legalNews: legalNewsList[index],
                  );
                },
              ),
            );
          } else if (state is LegalNewsFail) {
            return Column(
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.errMsg,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
