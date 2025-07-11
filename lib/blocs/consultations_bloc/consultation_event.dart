part of 'consultation_bloc.dart';

@immutable
sealed class ConsultationEvent {}

class AddConsultationEvent extends ConsultationEvent {
  final int consultationRequestId;
  final String resault;

  AddConsultationEvent(
      {required this.consultationRequestId, required this.resault});
}

class DeleteConsultationEvent extends ConsultationEvent {
  final int id;

  DeleteConsultationEvent({required this.id});
}

class UpdateConsultationEvent extends ConsultationEvent {}

class GetConsultationByIdEvent extends ConsultationEvent {
  final int id;

  GetConsultationByIdEvent({required this.id});
}

class GetAllConsultationsEvent extends ConsultationEvent {}

class EndConsultationRequestReview extends ConsultationEvent {
  final int consultationRequestId;

  EndConsultationRequestReview({required this.consultationRequestId});
}

class StartConsultationRequestReview extends ConsultationEvent {
  final int consultationRequestId;

  StartConsultationRequestReview({required this.consultationRequestId});
}
