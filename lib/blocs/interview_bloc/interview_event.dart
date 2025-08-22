import 'package:meta/meta.dart';

@immutable
sealed class InterviewEvent {}

class AddInterviewEvent extends InterviewEvent {
  final String date;
  final int jobAppId;
  AddInterviewEvent({
    required this.date,
    required this.jobAppId,
  });

}

class GetInterviewByIdEvent extends InterviewEvent {
  final int interviewId;

  GetInterviewByIdEvent({required this.interviewId});
}
class GetAllInterviewsEvent extends InterviewEvent {
  final int jobAppId;
  GetAllInterviewsEvent(this.jobAppId);
}

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
