class LegalNewsModel {
  final int id;
  final String title;
  final String description;
  final String createdAt;
  final String updatedAt;

  LegalNewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LegalNewsModel.fromJson(Map<String, dynamic> json) {
    return LegalNewsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }
}
