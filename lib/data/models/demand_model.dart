class DemandModel {
  DemandModel({
    required this.id,
    required this.date,
    required this.resault,
    required this.issueId,
    required this.lawyerId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final DateTime date;
  final String? resault;
  final int issueId;
  final int lawyerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory DemandModel.fromJson(Map<String, dynamic> json) {
    return DemandModel(
      id: json["id"],
      date: DateTime.parse(json["date"]),
      resault: json["resault"],
      issueId: json["issue_id"],
      lawyerId: json["lawyer_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
