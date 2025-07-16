import 'profile_model.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String? roleName;
  final int? roleId;
  final ProfileModel? profileModel;
  final int? employeeId;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.roleName,
    this.roleId,
    this.profileModel,
    this.employeeId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      roleId: json['role'] != null ? json['role']['id'] : null,
      roleName: json['role'] != null ? json['role']['name'] : null,
      profileModel: json['profile'] != null
          ? ProfileModel.fromjson(json['profile'])
          : null,
      employeeId: json['employee_id'], // هذا الحقل أيضًا قد يكون null
    );
  }
}
