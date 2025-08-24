import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/legal_books_bloc/legal_books_bloc.dart';
import '../../blocs/legal_books_bloc/legal_books_event.dart';
import '../../blocs/legal_books_bloc/legal_books_state.dart';
import '../../data/models/legal_book_model.dart';
import '../../themes.dart';
import '../screens/legal_books_screen/logal_book_detials.dart';

class LegalBookItem extends StatefulWidget {
  const LegalBookItem({super.key, required this.legalBook});

  final LegalBookModel legalBook;

  @override
  State<LegalBookItem> createState() => _LegalBookItemState();
}

class _LegalBookItemState extends State<LegalBookItem> {
  late bool isSaved;

  @override
  void initState() {
    super.initState();
    // مبدئياً نفترض false، أو يمكنك جلبها من الـ model إذا موجودة
    isSaved = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.lightBlue.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => LegalBookBloc(),
                  child: LegalBookDetailsScreen(
                    legalBook: widget.legalBook,
                  ),
                ),
              ),
            );
          },
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.withOpacity(0.1),
            child: const Icon(
              Icons.book,
              color: AppColors.darkBlue,
              size: 20,
            ),
          ),
          title: Text(
            ' ${widget.legalBook.bookTitle}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: AppColors.darkBlue,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ---------------------- زر الحفظ ----------------------
              BlocConsumer<LegalBookBloc, LegalBookState>(
                listener: (context, state) {
                  if (state is LegalBookSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(state.successMsg),
                      ),
                    );
                  } else if (state is LegalBookFail) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(state.errMsg),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      if (isSaved) {
                        BlocProvider.of<LegalBookBloc>(context).add(
                          UnSaveLegalBookEvent(bookId: widget.legalBook.id),
                        );
                      } else {
                        BlocProvider.of<LegalBookBloc>(context).add(
                          SaveLegalBookEvent(bookId: widget.legalBook.id),
                        );
                      }
                      setState(() {
                        isSaved = !isSaved;
                      });
                    },
                    icon: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: isSaved ? Colors.blue[900] : AppColors.darkBlue,
                    ),
                    tooltip: isSaved ? 'UnSave' : 'Save',
                  );
                },
              ),

              // ---------------------- زر الحذف ----------------------
              IconButton(
                onPressed: () {
                  BlocProvider.of<LegalBookBloc>(context).add(
                    DeleteLegalBookEvent(bookId: widget.legalBook.id),
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.darkBlue,
                  size: 24,
                ),
                tooltip: 'Delete Book',
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF1A237E),
                size: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
