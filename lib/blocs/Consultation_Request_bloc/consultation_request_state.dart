part of 'consultation_request_bloc.dart';

@immutable
sealed class ConsultationRequestState {}

final class ConsultationRequestInitial extends ConsultationRequestState {}


final class  ConsultationRequestSuccess extends ConsultationRequestState {
  final String successmsg;

  ConsultationRequestSuccess({required this.successmsg});
}

final class  ConsultationRequestSuccessFully extends ConsultationRequestState {
  final ConsReqModel consultationRequest;

  ConsultationRequestSuccessFully({required this.consultationRequest});
}

final class  ConsultationRequestListLoadedSuccessFully extends ConsultationRequestState {
  final List<ConsReqModel> consultationRequest;

  ConsultationRequestListLoadedSuccessFully({required this.consultationRequest});
}

final class  ConsultationRequestLoading extends ConsultationRequestState {}

final class  ConsultationRequestFail extends ConsultationRequestState {
  final String errmsg;

  ConsultationRequestFail({required this.errmsg});
}
