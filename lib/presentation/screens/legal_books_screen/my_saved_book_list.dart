import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/legal_books_bloc/legal_books_bloc.dart';
import '../../../blocs/legal_books_bloc/legal_books_event.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

import '../../widgets/custom_search_bar.dart';
import '../../widgets/my_saved_book_list.dart';
import 'add_logal_book.dart';

class MySavedBookListScreen extends StatefulWidget {
  const MySavedBookListScreen({super.key});

  @override
  State<MySavedBookListScreen> createState() => _MySavedBookListScreenState();
}

class _MySavedBookListScreenState extends State<MySavedBookListScreen> {
  late LegalBookBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<LegalBookBloc>(context);
    bloc.add(GetMySavedLegalBooksEvent());
  }

  void _onSearch(String bookTitle) {
    if (bookTitle.trim().isNotEmpty) {
      bloc.add(SearchLegalBooksByTitleEvent(bookTitle: bookTitle));
    } else {
      bloc.add(GetMySavedLegalBooksEvent());
    }
  }

  Future<void> _refreshBooks() async {
    // يمكنك إضافة delay إذا أردت محاكاة الانتظار
    bloc.add(GetMySavedLegalBooksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'My Saved Books',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Legal Book',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => LegalBookBloc(),
                child: const AddLegalBookScreen(),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomSearchBar(
              hint: 'Search by Title',
              onSearch: _onSearch,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshBooks,
                child:MyBookList(bloc: bloc),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
