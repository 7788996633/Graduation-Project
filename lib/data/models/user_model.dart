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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final role = json['role'] ?? {};

    return UserModel(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      roleId: role['id'] ?? -1,
      roleName: role['name'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': {
        'id': roleId,
        'name': roleName,
      },
    };
  }
}
