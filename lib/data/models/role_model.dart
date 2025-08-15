class RoleModel {
  final int id;
  final String name;

  RoleModel({
    required this.id,
    required this.name,
  });

  factory RoleModel.fromJson(Map<String, dynamic> data) {
    return RoleModel(
      id: data['id'],
      name: data['name'] ?? '',
    );
  }
}
