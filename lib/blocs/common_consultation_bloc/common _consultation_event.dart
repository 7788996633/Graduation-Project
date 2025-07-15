import 'package:meta/meta.dart';

@immutable
sealed class CommonConsultationEvent {}

class CreateCommonConsultationEvent extends CommonConsultationEvent {
  final String answer;
  final String  question;
  CreateCommonConsultationEvent({
    required this.answer,
    required this.question,

  });
}

class ShowCommonConsultationEvent extends CommonConsultationEvent {}

class GetAllCommonConsultation extends CommonConsultationEvent {}

class GetCommonConsultationById extends CommonConsultationEvent {
  final int id;
  GetCommonConsultationById({required this.id});
}

class UpdateCommonConsultationEvent extends CommonConsultationEvent {
  final int id;
  final String answer;
  UpdateCommonConsultationEvent({
    required this.id,
    required this.answer,
  });
}

class UpdateCommonConsultationStatusEvent extends CommonConsultationEvent {
  final int consultationId;
  final String status;
  UpdateCommonConsultationStatusEvent({
    required this.consultationId,
    required this.status,
  });
}

class DeleteCommonConsultationEvent extends CommonConsultationEvent {
  final int id;
  DeleteCommonConsultationEvent({
    required this.id,
  });
}
class SearchCommonConsultationsByQuestionEvent extends CommonConsultationEvent {
  final String question;
  SearchCommonConsultationsByQuestionEvent({required this.question});
}
