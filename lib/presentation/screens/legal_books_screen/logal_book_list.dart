import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/legal_books_bloc/legal_books_bloc.dart';
import '../../../blocs/legal_books_bloc/legal_books_event.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/legal_book_list.dart';
import '../../widgets/refresh_button.dart';
import '../../widgets/custom_search_bar.dart';  // إضافة ويدجت البحث

import 'add_logal_book.dart';  // شاشة إضافة كتاب قانوني (لازم تنشئها بنفس مسار add_session_type.dart)

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

  void _onSearch(String bookTitle) {
    if (bookTitle.trim().isNotEmpty) {
      bloc.add(SearchLegalBooksByTitleEvent(bookTitle: bookTitle));
    } else {
      bloc.add(GetAllLegalBooksEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Legal Books',
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
            LegalBookList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllLegalBooksEvent());
        },
      ),
    );
  }
}
