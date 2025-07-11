part of 'consultation_request_bloc.dart';

@immutable
sealed class ConsultationRequestEvent {}

class AddConsultationRequestEvent extends ConsultationRequestEvent {
  final String subject;
  final String details;

  AddConsultationRequestEvent({required this.subject, required this.details});
}

class UpdateConsultationRequestEvent extends ConsultationRequestEvent {
  final int id;
  final String subject;

  UpdateConsultationRequestEvent({required this.id, required this.subject});
}

class UpdateConsultationRequestStatusEvent extends ConsultationRequestEvent {
  final int id;
  final String status;

  UpdateConsultationRequestStatusEvent(
      {required this.id, required this.status});
}

class GetAllConsultationRequestStatusEvent extends ConsultationRequestEvent {}

class GetUserConsultationRequestStatusEvent extends ConsultationRequestEvent {}

class GetConsultationRequestStatusEvent extends ConsultationRequestEvent {
  final int id;

  GetConsultationRequestStatusEvent({required this.id});
}

class DeleteConsultationRequestStatusEvent extends ConsultationRequestEvent {
  final int id;

  DeleteConsultationRequestStatusEvent({required this.id});
}
