// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'session_appointment_bloc.dart';

@immutable
sealed class SessionAppointmentEvent {}

class GetAllAppointmentBySessionEvent extends SessionAppointmentEvent {
  final int sessionId;
  GetAllAppointmentBySessionEvent({
    required this.sessionId,
  });
}

class GetAppointmentEvent extends SessionAppointmentEvent {
  final int idAddAppiontment;

  GetAppointmentEvent({required this.idAddAppiontment});
}

class UpdateAppointmentEvent extends SessionAppointmentEvent {
  final int idAddAppiontment;
  final String date;
  final String type;
  UpdateAppointmentEvent(
      {required this.idAddAppiontment, required this.date, required this.type});
}

class DeleteAppiontmentEvent extends SessionAppointmentEvent {
  final int idDemand;
  final String date;
  final String type;
  DeleteAppiontmentEvent({
    required this.idDemand,
    required this.date,
    required this.type,
  });
}

class AddAppiontmentEvent extends SessionAppointmentEvent {
  final int sessionId;
  final String date;
  final String type;
  AddAppiontmentEvent({
    required this.sessionId,
    required this.date,
    required this.type,
  });
}
