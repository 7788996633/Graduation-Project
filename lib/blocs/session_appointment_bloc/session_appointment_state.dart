part of 'session_appointment_bloc.dart';

@immutable
sealed class SessionAppointmentState {}

final class SessionAppointmentInitial extends SessionAppointmentState {}

final class SessionAppointmentSuccess extends SessionAppointmentState {
  final String successmsg;
  SessionAppointmentSuccess({required this.successmsg});
}

final class SessionAppointmentLoadedSuccessfully
    extends SessionAppointmentState {
  final SessionAppointementModel session;

  SessionAppointmentLoadedSuccessfully({required this.session});
}

final class SessionAppointmentListLoadedSuccessfully
    extends SessionAppointmentState {
  final List<SessionAppointementModel> listAppointemnt;

  SessionAppointmentListLoadedSuccessfully({required this.listAppointemnt});
}

final class SessionAppointmentLoading extends SessionAppointmentState {}

final class SessionAppointmentFail extends SessionAppointmentState {
  final String errmsg;

  SessionAppointmentFail({required this.errmsg});
}
