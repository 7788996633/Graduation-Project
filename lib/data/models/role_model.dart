import 'user_model.dart';

class RoleModel {
  final int id;
  final String name;
  final String description;
  final List<UserModel> users; // إضافة قائمة المستخدمين

  RoleModel({
    required this.id,
    required this.name,
    required this.description,
    this.users = const [], // قيمة افتراضية فارغة
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json["id"],
      name: json['name'],
      description: json['description'],
      users: json['users'] != null
          ? List<UserModel>.from(
          json['users'].map((user) => UserModel.fromJson(user)))
          : [],
    );
  }
}
