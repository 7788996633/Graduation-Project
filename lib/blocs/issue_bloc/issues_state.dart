part of 'issues_bloc.dart';

@immutable
sealed class IssuesState {}

final class IssuesInitial extends IssuesState {}

final class IssuesSuccess extends IssuesState {
  final String successmsg;

  IssuesSuccess({required this.successmsg});
}

final class IssuesLoadedSuccessFully extends IssuesState {
  final IssuesModel issue;

  IssuesLoadedSuccessFully({required this.issue});
}

final class IssuesListLoadedSuccessFully extends IssuesState {
  final List<IssuesModel> issues;

  IssuesListLoadedSuccessFully({required this.issues});
}

final class IssuesLoading extends IssuesState {}

final class IssuesFail extends IssuesState {
  final String errmsg;

  IssuesFail({required this.errmsg});
}
