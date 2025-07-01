class IssueRequestModel {
  final int id;
  final int userId;
  final String title;
  final String description;
  final String status;
  final String? adminNote;
  final DateTime createdAt;
  final DateTime updatedAt;

  IssueRequestModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.status,
    required this.adminNote,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IssueRequestModel.fromJson(json) {
    return IssueRequestModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      adminNote: json['admin_note'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

enum IssueRequestStatus {
  approved,
  rejected,
}
