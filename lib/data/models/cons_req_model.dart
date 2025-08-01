
import 'user_model.dart';

class ConsReqModel {
  ConsReqModel({
    required this.id,
    required this.subject,
    required this.details,
    required this.status,
    required this.userId,
    required this.isLocked,
    required this.user,
    required this.date,
  });

  final int id;
  final String subject;
  final String details;
  final String status;
  final int userId;
  final int isLocked;
  final UserModel user;
  final DateTime date;

  factory ConsReqModel.fromJson(Map<String, dynamic> json) {
    return ConsReqModel(
      id: json["id"],
      subject: json["subject"],
      details: json["details"],
      status: json["status"],
      userId: json["user_id"],
      isLocked: json["is_locked"],
      user: UserModel.fromJson(
        json["user"],
      ),
      date: DateTime.parse(
        json["created_at"],
      ),
    );
  }
}

enum ConsReqModelStatus { pending, approved, rejected, closed }

String statusToString(ConsReqModelStatus s) {
  return s.name[0].toUpperCase() + s.name.substring(1).replaceAll('_', ' ');
}

ConsReqModelStatus stringToStatus(String s) {
  return ConsReqModelStatus.values.firstWhere(
    (e) => e.name.toLowerCase() == s.toLowerCase(),
    orElse: () => ConsReqModelStatus.pending,
  );
}
