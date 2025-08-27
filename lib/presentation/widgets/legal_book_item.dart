import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/legal_books_bloc/legal_books_bloc.dart';
import '../../blocs/legal_books_bloc/legal_books_event.dart';
import '../../blocs/legal_books_bloc/legal_books_state.dart';
import '../../constant.dart';
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
    isSaved = widget.legalBook.isSaved ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => LegalBookBloc(),
                child: LegalBookDetailsScreen(legalBook: widget.legalBook),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان + أيقونة الحذف للمسؤول
                Row(
                  children: [
                    const Icon(
                      Icons.book,
                      color: AppColors.darkBlue,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.legalBook.bookTitle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBlue,
                        ),
                      ),
                    ),
                    if (myRole != null && myRole.toLowerCase() == 'admin')
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<LegalBookBloc>(context).add(
                            DeleteLegalBookEvent(bookId: widget.legalBook.id),
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.darkBlue,
                          size: 20,
                        ),
                        tooltip: 'Delete Book',
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                // الوصف + أيقونة الحفظ بجانبه
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.legalBook.bookTitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
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
                                UnSaveLegalBookEvent(
                                    bookId: widget.legalBook.id),
                              );
                            } else {
                              BlocProvider.of<LegalBookBloc>(context).add(
                                SaveLegalBookEvent(
                                    bookId: widget.legalBook.id),
                              );
                            }
                            setState(() {
                              isSaved = !isSaved;
                            });
                          },
                          icon: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: isSaved ? Colors.orange : AppColors.darkBlue,
                          ),
                          tooltip: isSaved ? 'UnSave' : 'Save',
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
