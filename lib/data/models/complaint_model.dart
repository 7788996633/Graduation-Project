class ComplaintModel {
  ComplaintModel({
    required this.id,
    required this.description,
    required this.status,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String description;
  final String status;
  final int userId;
  final String createdAt;
  final String updatedAt;

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json["id"],
      description: json["description"] ?? "",
      status: json["status"] ?? "",
      userId: json["user_id"] ?? 0,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }
}
