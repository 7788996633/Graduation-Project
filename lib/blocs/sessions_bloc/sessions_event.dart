import 'package:meta/meta.dart';

@immutable
abstract class SessionsEvent {}

class CreateSessionsEvent extends SessionsEvent {
  final int sessionTypeId;
  final int lawyerId;
  final int issueId;

  CreateSessionsEvent({
    required this.sessionTypeId,
    required this.lawyerId,
    required this.issueId,

  });
}

class UpdateSessionEvent extends SessionsEvent {
  final String outcome;
  final int isAttend;
  final int sessionId;

  UpdateSessionEvent({
    required this.outcome,
    required this.isAttend,
    required this.sessionId,
  });
}

class GetAllSessionsEvent extends SessionsEvent {}

class GetLawyerSessionsEvent extends SessionsEvent {}

class GetClientSessionsEvent extends SessionsEvent {}

class GetSessionsByIdEvent extends SessionsEvent {
  final int sessionId;

  GetSessionsByIdEvent({required this.sessionId});
}

class DeleteSessionEvent extends SessionsEvent {
  final int sessionId;

  DeleteSessionEvent({required this.sessionId});
}
