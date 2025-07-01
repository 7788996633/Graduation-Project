import 'package:meta/meta.dart';

@immutable
sealed class InterviewEvent {}

class AddInterviewEvent extends InterviewEvent {
  final String date;

  AddInterviewEvent({
    required this.date,

  });
}

class GetInterviewByIdEvent extends InterviewEvent {
  final int interviewId;

  GetInterviewByIdEvent({required this.interviewId});
}

class GetAllInterviewsEvent extends InterviewEvent {}

class UpdateInterviewEvent extends InterviewEvent {
  final int interviewId;
  final String date;

  UpdateInterviewEvent({
    required this.interviewId,
    required this.date,
  });
}

class UpdateInterviewResultEvent extends InterviewEvent {
  final int interviewId;
  final String result;

  UpdateInterviewResultEvent({
    required this.interviewId,
    required this.result,
  });
}

class DeleteInterviewEvent extends InterviewEvent {
  final int interviewId;

  DeleteInterviewEvent({
    required this.interviewId,
  });
}
