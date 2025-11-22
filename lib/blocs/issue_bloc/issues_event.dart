part of 'issues_bloc.dart';

@immutable
sealed class IssuesEvent {}

class IssueAdd extends IssuesEvent {
  final String title;

  final String issueNumber;
  final int categoryId;

  final String courtName;

  final String status;
  final String priority;

  final String description;
  final String startDate;

  final String endDate;
  final String totalCost;
  final int numberOfPayments;
  final String opponentName;
  final int userId;
  final int amoountPaid;
  final String lawyersPercentage;
  IssueAdd(
      {required this.title,
      required this.issueNumber,
      required this.categoryId,
      required this.courtName,
      required this.status,
      required this.priority,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.totalCost,
      required this.numberOfPayments,
      required this.opponentName,
      required this.userId,
      required this.amoountPaid,
      required this.lawyersPercentage});
}

class IssueUpdate extends IssuesEvent {
  final int id;

  final String title;

  final String issueNumber;
  final String category;

  final String courtName;

  final String status;

  final String priority;
  final String startDate;

  final String endDate;
  final String totalCost;
  final int numberOfPayments;
  final String opponentName;

  IssueUpdate(
      {required this.id,
      required this.title,
      required this.issueNumber,
      required this.category,
      required this.courtName,
      required this.status,
      required this.priority,
      required this.startDate,
      required this.endDate,
      required this.totalCost,
      required this.numberOfPayments,
      required this.opponentName});
}

class Issuedelete extends IssuesEvent {
  final int id;

  Issuedelete({required this.id});
}

class IssueShowbyId extends IssuesEvent {
  final int id;

  IssueShowbyId({required this.id});
}

class GetAllIssuesEvent extends IssuesEvent {}

class GetAllLawyerIssuesEvent extends IssuesEvent {}

class GetAllClientIssuesEvent extends IssuesEvent {}

class AssignIsuueToLawyerEvent extends IssuesEvent {
  final int issueId;
  final List<int> lawyerIds;

  AssignIsuueToLawyerEvent({required this.issueId, required this.lawyerIds});
}

class UpdateIssuePriorityEvent extends IssuesEvent {
  final int issueId;
  final String priority;

  UpdateIssuePriorityEvent({required this.issueId, required this.priority});
}

class UpdateIssueStatusEvent extends IssuesEvent {
  final int issueId;
  final String status;

  UpdateIssueStatusEvent({required this.issueId, required this.status});
}

class GetIssuesByCategoryId extends IssuesEvent {
  final int categoryId;
  GetIssuesByCategoryId({required this.categoryId});
}

class FilterIssues extends IssuesEvent {
  final FiltersStrategy<IssuesModel> filter;

  FilterIssues(this.filter);
}

class ArchiveIssueEvent extends IssuesEvent {
  final int issueId;

  ArchiveIssueEvent({required this.issueId});
}

class UnArchiveIssueEvent extends IssuesEvent {
  final int issueId;

  UnArchiveIssueEvent({required this.issueId});
}

class GetArchivedIssueEvent extends IssuesEvent {
  final int issueId;

  GetArchivedIssueEvent({required this.issueId});
}

class GetAllArchivedIssuesEvent extends IssuesEvent {}

class GetMyArchivedIssuesEvent extends IssuesEvent {}

class UpdateArchivedIssuesEvent extends IssuesEvent {
  final int archiveId;
  final int points;

  UpdateArchivedIssuesEvent({
    required this.archiveId,
    required this.points,
  });
}

class DeleteArchivedIssuesEvent extends IssuesEvent {
  final int archiveId;

  DeleteArchivedIssuesEvent({
    required this.archiveId,
  });
}

class GetLawyerIssuesById extends IssuesEvent {
  final int lawyerId;

  GetLawyerIssuesById({required this.lawyerId});
}

class GetClientIssuesById extends IssuesEvent {
  final int clientId;

  GetClientIssuesById({required this.clientId});
}
