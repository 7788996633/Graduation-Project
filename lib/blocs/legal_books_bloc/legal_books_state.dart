
import 'package:meta/meta.dart';

import '../../data/models/legal_book_model.dart';

@immutable
sealed class LegalBookState {}

final class LegalBookInitial extends LegalBookState {}

final class LegalBookLoading extends LegalBookState {}

final class LegalBookSuccess extends LegalBookState {
  final String successMsg;

  LegalBookSuccess({required this.successMsg});
}

final class LegalBookLoaded extends LegalBookState {
  final LegalBookModel book;

  LegalBookLoaded({required this.book});
}

final class LegalBookListLoaded extends LegalBookState {
  final List<LegalBookModel> list;

  LegalBookListLoaded({required this.list});
}

final class LegalBookFail extends LegalBookState {
  final String errMsg;

  LegalBookFail({required this.errMsg});
}
