class ComplaintModel {
  final int id;
  final String description;
  final String status;
  final int userId;


  ComplaintModel({
    required this.id,
    required this.description,
    required this.status,
    required this.userId,

  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'] ?? 0,
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      userId: json['user_id'] ?? 0,

    );
  }
}
