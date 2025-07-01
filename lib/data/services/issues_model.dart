class IssuesModel {
  final int id;
  final String title;
  final String issueNumber;
  final String category;
  final String opponentName;
  final String courtName;
  final int numberOfPayments;
  final String totalCost;
  // final String amountPaid;
  // final String description;
  final int userId;
  final String status;
  final String priority;
  final String startDate;
  // final String endDate;
  final String createdAt;
  final String updatedAt;

  IssuesModel(
      {required this.id,
      required this.title,
      required this.issueNumber,
      required this.category,
      required this.opponentName,
      required this.courtName,
      required this.numberOfPayments,
      required this.totalCost,
      // required this.amountPaid,
      // required this.description,
      required this.userId,
      required this.status,
      required this.priority,
      required this.startDate,
      // required this.endDate,
      required this.createdAt,
      required this.updatedAt});

  factory IssuesModel.fromJson(Map<String, dynamic> json) {
    return IssuesModel(
        id: json['id'],
        title: json['title'],
        issueNumber: json['issue_number'],
        category: json['category'],
        opponentName: json['opponent_name'],
        courtName: json['court_name'],
        numberOfPayments: json['number_of_payments'],
        totalCost: json['total_cost'],
        // amountPaid: json['amount_paid'],
        // description: json['description'],
        userId: json['user_id'],
        status: json['status'],
        priority: json['priority'],
        startDate: json['start_date'],
        // endDate: json['end_date'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}

enum IssuePriority { low, medium, high , critical }
enum IssueStatus { open, in_Progress, closed }

String priorityToString(IssuePriority p) {
  return p.name[0].toUpperCase() + p.name.substring(1);
}

String statusToString(IssueStatus s) {
  return s.name[0].toUpperCase() + s.name.substring(1).replaceAll('_', ' ');
}

IssuePriority stringToPriority(String s) {
  return IssuePriority.values.firstWhere(
    (e) => e.name.toLowerCase() == s.toLowerCase(),
    orElse: () => IssuePriority.low,
  );
}

IssueStatus stringToStatus(String s) {
  return IssueStatus.values.firstWhere(
    (e) => e.name.toLowerCase() == s.toLowerCase(),
    orElse: () => IssueStatus.open,
  );
}
