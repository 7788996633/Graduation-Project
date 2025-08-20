import '../models/legal_book_model.dart';

import '../services/legal_book_services.dart';

class LegalBookRepository {
  Future<List<LegalBookModel>> getLegalBooks() async {
    var legalBooksList = await LegalBookServices().getAllLegalBooks();
    return legalBooksList
        .map(
          (e) => LegalBookModel.fromJson(e),
    )
        .toList();
  }

  Future<List<LegalBookModel>> getMySavedLegalBooks() async {
    var legalBooksList = await LegalBookServices().getMySavedLegalBooks();
    return legalBooksList
        .map(
          (e) => LegalBookModel.fromJson(e),
    )
        .toList();
  }
}
