class HiringRequestModel {
  HiringRequestModel({
    required this.id,
    required this.jopTitle,
    required this.type,
    required this.description,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String jopTitle;
  final String type;
  final String description;
  final String status;
  final int createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory HiringRequestModel.fromJson(Map<String, dynamic> json){
    return HiringRequestModel(
      id: json["id"],
      jopTitle: json["jopTitle"],
      type: json["type"],
      description: json["description"],
      status: json["status"],
      createdBy: json["created_by"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
enum  HiringStatus  {draft,published,closed,canceled,archived}
extension HiringStatusExtension on HiringStatus {
  String toShortString() {
    return toString()
        .split('.')
        .last;
  }

  static HiringStatus fromString(String status) {
    return HiringStatus.values.firstWhere(
          (e) => e.toShortString() == status,
      orElse: () => HiringStatus.draft, // حالة افتراضية
    );
  }}