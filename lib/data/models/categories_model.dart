class CategoriesModel {
  final int id;
  final String name;
  final int? parentId;
  final String? type;
  final List<CategoriesModel> children;

  CategoriesModel({
    required this.id,
    required this.name,
    this.parentId,
    this.type,
    required this.children,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    List jsonChildren = json['children'];
    return CategoriesModel(
        id: json['id'],
        name: json['name'],
        parentId: json['parent_id'],
        type: json['type'],
        children: jsonChildren
            .map(
              (e) => CategoriesModel.fromJson(e),
            )
            .toList());
  }
}
