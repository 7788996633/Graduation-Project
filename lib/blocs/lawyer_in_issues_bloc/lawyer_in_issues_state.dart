part of 'lawyer_in_issues_bloc.dart';

@immutable
sealed class LawyerInIssuesState {}

final class LawyerInIssuesInitial extends LawyerInIssuesState {}

class LawyerInIssuesLoadedSuccessfully extends LawyerInIssuesState {
  final List<LawyerInIssues> lawyerInissues;

  LawyerInIssuesLoadedSuccessfully({required this.lawyerInissues});
}

final class LawyerInIssuesLoading extends LawyerInIssuesState {}

final class LawyerInIssuesFail extends LawyerInIssuesState {
  final String errmsg;

  LawyerInIssuesFail({required this.errmsg});
}
