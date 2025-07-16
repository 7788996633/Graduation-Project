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
    // إذا الـ json يحتوي على "category" و "issues" (مثل طلب getIssuesByCategory)
    if (json.containsKey('category') && json.containsKey('issues')) {
      final category = json['category'];
      return CategoriesModel(
        id: category['id'] ?? 0,
        name: category['name'] ?? '',
        parentId: category['parent_id'],
        type: category['type'],
        children: [], // مافي children بهذا الطلب
        issues: List<IssuesModel>.from(
          (json['issues'] as List).map((e) => IssuesModel.fromJson(e)),
        ),
      );
    }

    // الحالة العادية (من طلب getAllCategories)
    return CategoriesModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      parentId: json['parent_id'],
      type: json['type'],
      children: json['children'] != null
          ? List<CategoriesModel>.from(
          (json['children'] as List).map((child) => CategoriesModel.fromJson(child)))
          : [],
      issues: json['issues'] != null
          ? List<IssuesModel>.from(
          (json['issues'] as List).map((issue) => IssuesModel.fromJson(issue)))
          : [],
    );
  }
}
