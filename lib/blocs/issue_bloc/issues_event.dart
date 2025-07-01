part of 'issues_bloc.dart';

@immutable
sealed class IssuesEvent {}

class IssueAdd extends IssuesEvent {
  final String title;

  final String issueNumber;
  final String category;

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
  IssueAdd({
    required this.title,
    required this.issueNumber,
    required this.category,
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
  });
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
