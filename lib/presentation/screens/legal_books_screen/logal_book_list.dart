import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/legal_books_bloc/legal_books_bloc.dart';
import '../../../blocs/legal_books_bloc/legal_books_event.dart';
import '../../../blocs/legal_books_bloc/legal_books_state.dart';
import '../../../constant.dart';
import '../../../data/models/legal_book_model.dart';
import '../../../themes.dart';

import '../../widgets/custom_appbar_add.dart';
import '../../widgets/legal_book_item.dart';
import 'add_logal_book.dart';
import 'my_saved_book_list.dart';

class ListLegalBooksScreen extends StatefulWidget {
  const ListLegalBooksScreen({super.key});

  @override
  State<ListLegalBooksScreen> createState() => _ListLegalBooksScreenState();
}

class _ListLegalBooksScreenState extends State<ListLegalBooksScreen> {
  late LegalBookBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<LegalBookBloc>(context);
    bloc.add(GetAllLegalBooksEvent());
  }

  Future<void> _onRefresh() async {
    bloc.add(GetAllLegalBooksEvent());
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Legal Books',
        actionIcon: (myRole== 'admin')
            ? Icons.add_circle_rounded
            : Icons.book,
        tooltip: 'Add New Legal Book',
        onActionPressed: () {
          if (myRole == 'admin') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => LegalBookBloc(),
                  child: const AddLegalBookScreen(),
                ),
              ),
            );
          }
        },
         secondaryIcon: Icons.bookmark,
        secondaryTooltip: 'My Saved Books',
        onSecondaryPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => LegalBookBloc(),
                child: const MySavedBookListScreen(),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<LegalBookBloc, LegalBookState>(
            builder: (context, state) {
              if (state is LegalBookLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LegalBookFail) {
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
              } else if (state is LegalBookListLoaded) {
                final List<LegalBookModel> bookList = state.list;
                if (bookList.isEmpty) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('No Legal Books Available'),
                        ),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: bookList.length,
                  itemBuilder: (context, index) {
                    return LegalBookItem(legalBook: bookList[index]);
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
