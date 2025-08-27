class ComplaintModel {
  final int id;
  final String description;
  final String status;

final String userName;

  ComplaintModel({
    required this.id,
    required this.description,
    required this.status,

 required this.userName
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'] ?? 0,
      description: json['description'] ?? '',
      status: json['status'] ?? '',

      userName: json['user']['name'] ??"aaaaaaaaaaaaa",
    );
  }
}
