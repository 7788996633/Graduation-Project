import '../models/legal_news_model.dart';
import '../services/legal_news_services.dart';

class LegalNewsRepository {
  Future<List<LegalNewsModel>> getLegalNews() async {
    var legalNewsList = await LegalNewsServices().getAllLegalNews();
    return legalNewsList
        .map(
          (e) => LegalNewsModel.fromJson(e),
    )
        .toList();
  }

  Future<List<LegalNewsModel>> getMySavedLegalNews() async {
    var legalNewsList = await LegalNewsServices().mySavedLegalNews();
    return legalNewsList
        .map(
          (e) => LegalNewsModel.fromJson(e),
    )
        .toList();
  }

  Future<List<LegalNewsModel>> getLegalNewsLatest() async {
    var legalNewsList = await LegalNewsServices().getLateNews();
    return legalNewsList
        .map(
          (e) => LegalNewsModel.fromJson(e),
    )
        .toList();
  }
}
