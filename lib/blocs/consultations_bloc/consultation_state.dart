part of 'consultation_bloc.dart';

@immutable
sealed class ConsultationState {}

final class ConsultationInitial extends ConsultationState {}

final class ConsultationLoading extends ConsultationState {}

final class ConsultationSuccess extends ConsultationState {
  final String successmsg;

  ConsultationSuccess({required this.successmsg});
}

final class ConsultationFail extends ConsultationState {
  final String errmsg;

  ConsultationFail({required this.errmsg});
}

final class ConsultationLoadedSuccessfully extends ConsultationState {
  final ConsultationModel consultationModel;

  ConsultationLoadedSuccessfully({required this.consultationModel});
}

final class ConsultationsListLoadedSuccessfully extends ConsultationState {
  final List<ConsultationModel> consultations;

  ConsultationsListLoadedSuccessfully({required this.consultations});
}
