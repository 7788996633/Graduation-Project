class UserModel {
  final int id;
  final String name;
  final String email;
  final String roleName;
  final int roleId;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.roleName,
    required this.roleId,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      roleId: json['role']['id'],
      roleName: json['role']['name'],
    );
  }
}
