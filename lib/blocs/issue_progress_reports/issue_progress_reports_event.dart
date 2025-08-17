import 'package:meta/meta.dart';

@immutable
sealed class IssueProgressReportEvent {}

class AddIssueProgressReportEvent extends IssueProgressReportEvent {
  final String report;
  final int sessionId;

  AddIssueProgressReportEvent({
    required this.sessionId,
    required this.report,
  });
}

class GetIssueProgressReportByIdEvent extends IssueProgressReportEvent {
  final int reportId;
  GetIssueProgressReportByIdEvent({required this.reportId});
}

class GetAllIssueProgressReportsEvent extends IssueProgressReportEvent {}

class UpdateIssueProgressReportEvent extends IssueProgressReportEvent {
  final int reportId;
  final String report;

  UpdateIssueProgressReportEvent({
    required this.reportId,
    required this.report,
  });
}

class DeleteIssueProgressReportEvent extends IssueProgressReportEvent {
  final int reportId;

  DeleteIssueProgressReportEvent({
    required this.reportId,
  });
}
