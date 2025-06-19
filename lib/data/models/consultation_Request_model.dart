class ConsultationRequestModel {
  ConsultationRequestModel({
    required this.id,
    required this.subject,
    required this.details,
    required this.status,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  final int id;
  final String subject;
  final String details;
  final String status;
  final int userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;

  factory ConsultationRequestModel.fromJson(Map<String, dynamic> json){
    return ConsultationRequestModel(
      id: json["id"],
      subject: json["subject"],
      details: json["details"],
      status: json["status"],
      userId: json["user_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      user: json["user"] == null ? null: User.fromJson(json["user"]),
    );
  }

}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String email;
  final int? roleId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      roleId: json["role_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
