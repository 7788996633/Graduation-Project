class ConsultationRequestModel {
  ConsultationRequestModel({
    required this.id,
    required this.subject,
    required this.details,
    required this.status,
    required this.userId,
  });

  final int id;
  final String subject;
  final String details;
  final String status;
  final int userId;

  factory ConsultationRequestModel.fromJson(Map<String, dynamic> json) {
    return ConsultationRequestModel(
      id: json["id"],
      subject: json["subject"],
      details: json["details"],
      status: json["status"],
      userId: json["user_id"],
    );
  }
}
