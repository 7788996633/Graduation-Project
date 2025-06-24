import 'package:graduation/data/models/user_model.dart';

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
  final UserModel? user;

  factory ConsultationRequestModel.fromJson(Map<String, dynamic> json){
    return ConsultationRequestModel(
      id: json["id"],
      subject: json["subject"],
      details: json["details"],
      status: json["status"],
      userId: json["user_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      user: json["user"] == null ? null: UserModel.fromJson(json["user"]),
    );
  }

}
