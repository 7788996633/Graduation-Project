import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/legal_books_bloc/legal_books_bloc.dart';
import '../../../blocs/legal_books_bloc/legal_books_event.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/legal_book_list.dart';
import '../../widgets/custom_search_bar.dart';  // ويدجت البحث

import 'add_logal_book.dart';
import 'my_saved_book_list.dart';  // شاشة إضافة كتاب قانوني

class ListLegalBooksScreen extends StatefulWidget {
  const ListLegalBooksScreen({super.key});

  @override
  State<ListLegalBooksScreen> createState() => _ListLegalBooksScreenState();
}

class _ListLegalBooksScreenState extends State<ListLegalBooksScreen> {
  late LegalBookBloc bloc;

  // هنا تقدر تجيب الدور من أي مكان (API, SharedPreferences, Provider...)
  // حالياً رح أفترض إنك جبت الدور بهالمتغير
  final String myRole = "admin"; // جرّب غيّرها لـ "user" وشوف

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
        actionIcon: myRole == "admin" ? Icons.add_circle_rounded : null,
        tooltip: myRole == "admin" ? 'Add New Legal Book' : null,
        onActionPressed: myRole == "admin"
            ? () {
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
            : null,
        secondaryIcon: Icons.bookmark, // أيقونة لزر "My Saved News"
        secondaryTooltip: 'My Saved News',
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
        child: Column(
          children: [
            CustomSearchBar(
              hint: 'Search by Title',
              onSearch: _onSearch,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  bloc.add(GetAllLegalBooksEvent());
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: LegalBookList(bloc: bloc),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
