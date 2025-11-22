part of 'lawyer_in_issues_bloc.dart';

@immutable
sealed class LawyerInIssuesEvent {}

class GetAllLawyersInIssuesEvent extends LawyerInIssuesEvent {
  final int issueId;

  GetAllLawyersInIssuesEvent({required this.issueId});
}
