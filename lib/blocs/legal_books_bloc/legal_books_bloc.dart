import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/legal_book_model.dart';

import '../../data/repositories/legal_book_repository.dart';
import '../../data/services/legal_book_services.dart';
import 'legal_books_event.dart';
import 'legal_books_state.dart';

class LegalBookBloc extends Bloc<LegalBookEvent, LegalBookState> {
  LegalBookBloc() : super(LegalBookInitial()) {
    List<LegalBookModel> allBooks = [];

    on<LegalBookEvent>((event, emit) async {
      if (event is AddLegalBookEvent) {
        emit(LegalBookLoading());
        try {

          String result = await LegalBookServices()
              .addLegalBook(event.file, event.bookTitle, event.fileName);
          emit(LegalBookSuccess(successMsg: result));
        } catch (e) {
          emit(LegalBookFail(errMsg: e.toString()));
        }
      }
      else if (event is SaveLegalBookEvent) {
        emit(LegalBookLoading());
        try {

          String result = await LegalBookServices()
              .saveLegalBook(event.bookId);
          emit(LegalBookSuccess(successMsg: result));
        } catch (e) {
          emit(LegalBookFail(errMsg: e.toString()));
        }
      }
      else if (event is GetLegalBookByIdEvent) {
        emit(LegalBookLoading());
        try {
          LegalBookModel book = await LegalBookServices()
              .getLegalBookById(event.bookId);
          emit(LegalBookLoaded(book: book));
        } catch (e) {
          emit(LegalBookFail(errMsg: e.toString()));
        }
      } else if (event is GetAllLegalBooksEvent) {
        emit(LegalBookLoading());
        try {
          allBooks = await LegalBookRepository().getLegalBooks();
          emit(LegalBookListLoaded(list: allBooks));
        } catch (e) {
          emit(LegalBookFail(errMsg: e.toString()));
        }
      }
      else if (event is GetMySavedLegalBooksEvent) {
        emit(LegalBookLoading());
        try {
          allBooks = await LegalBookRepository().getMySavedLegalBooks();
          emit(LegalBookListLoaded(list: allBooks));
        } catch (e) {
          emit(LegalBookFail(errMsg: e.toString()));
        }
      } else if (event is SearchLegalBooksByTitleEvent) {
        emit(LegalBookLoading());
        try {
          final searchLower = event.bookTitle.trim().toLowerCase();

          final filteredList = allBooks.where((book) {
            final title = book.bookTitle.toLowerCase();
            return title.contains(searchLower);
          }).toList();

          emit(LegalBookListLoaded(list: filteredList));
        } catch (e) {
          emit(LegalBookFail(errMsg: e.toString()));
        }
      } else if (event is UpdateLegalBookEvent) {
        emit(LegalBookLoading());
        try {

          String result = await LegalBookServices().updateLegalBook(
            bookId: event.bookId,
            bookTitle: event.bookTitle,
            fileName: event.fileName,
            file: event.file,
          );
          emit(LegalBookSuccess(successMsg: result));
        } catch (e) {
          emit(LegalBookFail(errMsg: e.toString()));
        }
      } else if (event is DeleteLegalBookEvent) {
        emit(LegalBookLoading());
        try {
          String result = await LegalBookServices()
              .deleteLegalBook(event.bookId);
          emit(LegalBookSuccess(successMsg: result));
        } catch (e) {
          emit(LegalBookFail(errMsg: e.toString()));
        }
      }else if (event is UnSaveLegalBookEvent) {
        emit(LegalBookLoading());
        try {
          String result = await LegalBookServices()
              .unSaveLegalBook(event.bookId);
          emit(LegalBookSuccess(successMsg: result));
        } catch (e) {
          emit(LegalBookFail(errMsg: e.toString()));
        }
      }
    });
  }
}
