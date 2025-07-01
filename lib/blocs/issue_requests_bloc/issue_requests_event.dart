import 'package:meta/meta.dart';

@immutable
sealed class IssueRequestsEvent {}

class CreateIssueRequestsEvent extends IssueRequestsEvent {
  final String title;
  final String description;
  CreateIssueRequestsEvent({
    required this.title,
    required this.description,
  });
}

class ShowIssueRequestsEvent extends IssueRequestsEvent {}

class GetAllIssueRequestsEvent extends IssueRequestsEvent {}

class GetIssueRequestsByIdEvent extends IssueRequestsEvent {
  final int issueRequestsId;

  GetIssueRequestsByIdEvent({required this.issueRequestsId});
}

class DeleteIssueRequestEvent extends IssueRequestsEvent {
  final int issueRequestId;

  DeleteIssueRequestEvent({required this.issueRequestId});
}

class UpdateIssueRequestEvent extends IssueRequestsEvent {
  final int issueRequestId;
  final String title;
  final String description;

  UpdateIssueRequestEvent({
    required this.issueRequestId,
    required this.title,
    required this.description,
  });
}

class UpdateIssueRequestEventAsAnAdmin extends IssueRequestsEvent {
  final int issueRequestId;
  final String adminNote;
  final String status;

  UpdateIssueRequestEventAsAnAdmin(
      {required this.issueRequestId,
      required this.adminNote,
      required this.status});
}
