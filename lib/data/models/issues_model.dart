
import 'user_model.dart';

class IssuesModel {
  final int id;
  final String title;
  final String issueNumber;
  final int category;
  final String opponentName;
  final String courtName;
  final int numberOfPayments;
  final String totalCost;
  final String amountPaid;
  final UserModel user;
  final String status;
  final String priority;
  final String startDate;
  final String endDate;
  final String createdAt;
  final String updatedAt;

  IssuesModel({
    required this.id,
    required this.title,
    required this.issueNumber,
    required this.category,
    required this.opponentName,
    required this.courtName,
    required this.numberOfPayments,
    required this.totalCost,
    required this.amountPaid,
    required this.user,
    required this.status,
    required this.priority,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IssuesModel.fromJson(Map<String, dynamic> json) {
    return IssuesModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      issueNumber: json['issue_number'] ?? '',
      category: json['category_id'] ?? '',
      opponentName: json['opponent_name'] ?? '',
      courtName: json['court_name'] ?? '',
      numberOfPayments: json['number_of_payments'] ?? 0,
      totalCost: json['total_cost']?.toString() ?? '',
      amountPaid: json['amount_paid']?.toString() ?? '',
      user: UserModel.fromJson(
        json['user'],
      ),
      status: json['status'] ?? '',
      priority: json['priority'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

// Enums
enum IssuePriority { normal, medium, high, critical }

enum IssueStatus { open, in_progress, closed, archived }

// Enum <-> String Helpers
String priorityToString(IssuePriority p) {
  return p.name[0].toUpperCase() + p.name.substring(1);
}

String statusToString(IssueStatus s) {
  return s.name[0].toUpperCase() + s.name.substring(1).replaceAll('_', ' ');
}

IssuePriority stringToPriority(String s) {
  return IssuePriority.values.firstWhere(
    (e) => e.name.toLowerCase() == s.toLowerCase(),
    orElse: () => IssuePriority.normal,
  );
}

IssueStatus stringToStatus(String s) {
  final normalized = s.toLowerCase().replaceAll(' ', '_');
  return IssueStatus.values.firstWhere(
    (e) => e.name == normalized,
    orElse: () => IssueStatus.in_progress,
  );
}
