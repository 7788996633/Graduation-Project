import 'package:meta/meta.dart';

@immutable
sealed class LegalBookEvent {}

class AddLegalBookEvent extends LegalBookEvent {
  final dynamic file;
  final String bookTitle;
  final String fileName;

  AddLegalBookEvent({
    required this.file,
    required this.bookTitle,
    required this.fileName,
  });
}


class GetLegalBookByIdEvent extends LegalBookEvent {
  final int bookId;

  GetLegalBookByIdEvent({required this.bookId});
}

class GetAllLegalBooksEvent extends LegalBookEvent {}

class SearchLegalBooksByTitleEvent extends LegalBookEvent {
  final String bookTitle;

  SearchLegalBooksByTitleEvent({required this.bookTitle});
}

class UpdateLegalBookEvent extends LegalBookEvent {
  final int bookId;
  final dynamic? file; // يمكن null
  final String bookTitle;
  final String fileName;

  UpdateLegalBookEvent({
    required this.bookId,
    this.file,
    required this.bookTitle,
    required this.fileName,
  });
}


class DeleteLegalBookEvent extends LegalBookEvent {
  final int bookId;

  DeleteLegalBookEvent({required this.bookId});
}
