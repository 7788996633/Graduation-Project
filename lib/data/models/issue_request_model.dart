import 'package:graduation/data/models/user_model.dart';

class IssueRequestModel {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String status;
  final String? adminNote;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel userModel;
  IssueRequestModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.description,
      required this.status,
      required this.adminNote,
      required this.createdAt,
      required this.updatedAt,
      required this.userModel});

  factory IssueRequestModel.fromJson(json) {
    return IssueRequestModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      adminNote: json['admin_note'],
      createdAt: DateTime.parse(
        json['created_at'],
      ),
      updatedAt: DateTime.parse(
        json['updated_at'],
      ),
      userModel: UserModel.fromJson(
        json['user'],
      ),
    );
  }
}

enum IssueRequestStatus {
  approved,
  pending,
  rejected,
}

String statusToString(IssueRequestStatus s) {
  return s.name[0].toUpperCase() + s.name.substring(1).replaceAll('_', ' ');
}

IssueRequestStatus stringToStatus(String s) {
  final normalized = s.toLowerCase();
  return IssueRequestStatus.values.firstWhere(
    (e) => e.name == normalized,
    orElse: () => IssueRequestStatus.pending,
  );
}
