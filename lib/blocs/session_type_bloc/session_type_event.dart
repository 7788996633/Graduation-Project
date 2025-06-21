import 'package:meta/meta.dart';

@immutable
sealed class SessionTypeEvent {}

class AddSessionTypeEvent extends SessionTypeEvent {
  final String type;
  final int points;
  final String description;

  AddSessionTypeEvent({
    required this.type,
    required this.points,
    required this.description,
  });
}

class GetSessionTypeByIdEvent extends SessionTypeEvent {
  final int sessionTypeId;

  GetSessionTypeByIdEvent({required this.sessionTypeId});
}

class GetAllSessionTypesEvent extends SessionTypeEvent {}

class UpdateSessionTypeEvent extends SessionTypeEvent {
  final int sessionTypeId;
  final int points;

  UpdateSessionTypeEvent({
    required this.sessionTypeId,
    required this.points,

  });
}

class DeleteSessionTypeEvent extends SessionTypeEvent {
  final int sessionTypeId;

  DeleteSessionTypeEvent({
    required this.sessionTypeId,
  });}

