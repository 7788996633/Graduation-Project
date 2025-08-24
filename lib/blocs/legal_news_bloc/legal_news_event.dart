import 'package:meta/meta.dart';

@immutable
sealed class LegalNewsEvent {}



class AddLegalNewsEvent extends LegalNewsEvent {
  final String title;
  final String description;

  AddLegalNewsEvent({
    required this.title,
    required this.description,
  });
}

class GetAllLegalNewsEvent extends LegalNewsEvent {}
class MySavedLegalNewsEvent extends LegalNewsEvent {}
class LegalNewsLatestEvent extends LegalNewsEvent {}

class GetLegalNewsByIdEvent extends LegalNewsEvent {
  final int newsId;

  GetLegalNewsByIdEvent({required this.newsId});
}
class DeleteLegalNewsEvent extends LegalNewsEvent {
  final int legalNewsId;

  DeleteLegalNewsEvent({
    required this.legalNewsId,
  });
}
class SaveLegalNewsEvent extends LegalNewsEvent {
  final int legalNewsId;
  SaveLegalNewsEvent({
    required this.legalNewsId,
  });
}

class UnSaveLegalNewsEvent extends LegalNewsEvent {
  final int legalNewsId;
  UnSaveLegalNewsEvent({required this.legalNewsId});
}
class UpdateLegalNewsEvent extends LegalNewsEvent {
  final int newsId;
  final String title;
  final String description;

  UpdateLegalNewsEvent({
    required this.newsId,
    required this.title,
    required this.description,
  });
}
