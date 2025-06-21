class FurloughRequestModel {
  FurloughRequestModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.cause,
    required this.status,
    required this.covetByType,
    required this.covetById,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final DateTime startDate;
  final DateTime endDate;
  final String cause;
  final String status;
  final String covetByType;
  final int covetById;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory FurloughRequestModel.fromJson(Map<String, dynamic> json) {
    return FurloughRequestModel(
      id: json["id"],
      startDate: DateTime.parse(json["start_date"]),
      endDate: DateTime.parse(json["end_date"]),
      cause: json["cause"],
      status: json["status"],
      covetByType: json["covet_by_type"],
      covetById: json["covet_by_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
