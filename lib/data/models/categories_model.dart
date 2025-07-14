class CategoriesModel {
  final int id;
  final String name;
  final int? parentId;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<CategoriesModel> children;

  CategoriesModel({
    required this.id,
    required this.name,
    this.parentId,
    this.type,
    this.createdAt,
    this.updatedAt,
    required this.children,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      parentId: json['parent_id'] != null
          ? int.tryParse(json['parent_id'].toString())
          : null,
      type: json['type']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
      children: json['children'] != null
          ? List<CategoriesModel>.from(
          (json['children'] as List).map((child) => CategoriesModel.fromJson(child)))
          : [],
    );
  }
}
