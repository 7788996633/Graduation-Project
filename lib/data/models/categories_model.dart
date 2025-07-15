import 'issues_model.dart';

class CategoriesModel {
  final int id;
  final String name;
  final int? parentId;
  final String? type;
  final List<CategoriesModel> children;
  final List<IssuesModel> issues;

  CategoriesModel({
    required this.id,
    required this.name,
    this.parentId,
    this.type,
    required this.children,
    required this.issues,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      parentId: json['parent_id'],
      type: json['type'],
      children: json['children'] != null
          ? List<CategoriesModel>.from(
          (json['children'] as List)
              .map((child) => CategoriesModel.fromJson(child)))
          : [],
      issues: json['issues'] != null
          ? List<IssuesModel>.from(
          (json['issues'] as List)
              .map((issue) => IssuesModel.fromJson(issue)))
          : [],
    );
  }
}
