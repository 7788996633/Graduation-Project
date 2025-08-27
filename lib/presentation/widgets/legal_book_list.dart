import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/legal_books_bloc/legal_books_bloc.dart';
import '../../blocs/legal_books_bloc/legal_books_event.dart';
import '../../blocs/legal_books_bloc/legal_books_state.dart';

import '../../data/models/legal_book_model.dart';
import 'legal_book_item.dart';  // لازم تنشئ هذا الwidget مشابه لهيرينغ ريكويست ايتيم

class LegalBookList extends StatefulWidget {
  const LegalBookList({super.key, required this.bloc});
  final LegalBookBloc bloc;

  @override
  State<LegalBookList> createState() => _LegalBookListState();
}

class _LegalBookListState extends State<LegalBookList> {
  List<LegalBookModel> legalBookList = [];

  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllLegalBooksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LegalBookBloc, LegalBookState>(
      listener: (context, state) {
        if (state is LegalBookSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllLegalBooksEvent());
        } else if (state is LegalBookFail) {
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
      child: BlocBuilder<LegalBookBloc, LegalBookState>(
        builder: (context, state) {
          if (state is LegalBookListLoaded) {
            legalBookList = state.list;
            if (legalBookList.isEmpty) {
              return const Center(child: Text('There are no legal books.'));
            }
            return  ListView.builder(
                itemCount: legalBookList.length,
                itemBuilder: (context, index) {
                  return LegalBookItem(
                    legalBook: legalBookList[index],
                  );
                },

            );
          } else if (state is LegalBookFail) {
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
