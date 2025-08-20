part of 'session_points_bloc.dart';

@immutable
sealed class SessionPointsEvent {}

class GetAllPointByIssueId extends SessionPointsEvent {
  final int issueId;

  GetAllPointByIssueId({required this.issueId});
}

class EvaluateLawyerPoints extends SessionPointsEvent {
  final int sessionId;
  final int lawyerId;
  final int points;
  final String? notes;

  EvaluateLawyerPoints({
    required this.sessionId,
    required this.lawyerId,
    required this.points,
    required this.notes,
  });
}
