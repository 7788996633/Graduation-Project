class PermissionModel {
  PermissionModel({
    required this.id,
    required this.name,
  //  required this.appRouteId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
 // final int appRouteId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory PermissionModel.fromJson(Map<String, dynamic> json){
    return PermissionModel(
      id: json["id"],
      name: json["name"],
    //  appRouteId: json["app_route_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
