import 'package:meta/meta.dart';

@immutable
sealed class InterviewEvent {}

class AddInterviewEvent extends InterviewEvent {
  final String type;
  final int points;
  final String description;

  AddInterviewEvent({
    required this.type,
    required this.points,
    required this.description,
  });
}

class GetInterviewByIdEvent extends InterviewEvent {
  final int interviewId;

  GetInterviewByIdEvent({required this.interviewId});
}

class GetAllInterviewsEvent extends InterviewEvent {}

class UpdateInterviewEvent extends InterviewEvent {
  final int interviewId;
  final int points;

  UpdateInterviewEvent({
    required this.interviewId,
    required this.points,
  });
}

class DeleteInterviewEvent extends InterviewEvent {
  final int interviewId;

  DeleteInterviewEvent({
    required this.interviewId,
  });
}
