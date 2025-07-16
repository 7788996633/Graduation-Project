import 'package:graduation/data/models/profile_model.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String roleName;
  final int roleId;
  final ProfileModel profileModel;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.roleName,
    required this.roleId,
    required this.profileModel,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      roleId: json['role']['id'],
      roleName: json['role']['name'],
      profileModel: ProfileModel.fromjson(
        json['profile'],
      ),
    );
  }
}
