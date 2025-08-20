class RoleModel {
  final String name;

  RoleModel({
    required this.name,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      name: json['name'],
    );
  }
}
