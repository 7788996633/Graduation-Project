part of 'lawyer_in_issues_bloc.dart';

@immutable
sealed class LawyerInIssuesEvent {}

class CreateUserProfileEvent extends LawyerInIssuesEvent {
  CreateUserProfileEvent();
}
