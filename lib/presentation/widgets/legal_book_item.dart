import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/legal_books_bloc/legal_books_bloc.dart';
import '../../data/models/legal_book_model.dart';
import '../../themes.dart';
import '../screens/legal_books_screen/logal_book_detials.dart';

class LegalBookItem extends StatelessWidget {
  const LegalBookItem({super.key, required this.legalBook});

  final LegalBookModel legalBook;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(color: AppColors.darkBlue, width: 1.5),
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
                    legalBook: legalBook,
                  ),
                ),
              ),
            );
          },
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey.withOpacity(0.1),
            child: const Icon(
              Icons.book,
              color: AppColors.darkBlue,
              size: 24,
            ),
          ),
          title: Text(
            legalBook.book,  // عنوان الكتاب
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColors.darkBlue,
            ),
          ),
          subtitle: Text(
            'Author: ${legalBook.bookTitle ?? 'Unknown'}', // اسم المؤلف أو حقل مشابه
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(0xFF1A237E),
            size: 20,
          ),
        ),
      ),
    );
  }
}
