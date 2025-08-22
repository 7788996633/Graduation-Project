class PermissionModel {
  final int id;
  final String name;
  final int appRouteId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PivotModel? pivot;

  PermissionModel({
    required this.id,
    required this.name,
    required this.appRouteId,
    required this.createdAt,
    required this.updatedAt,
    this.pivot,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    return PermissionModel(
      id: json['id'],
      name: json['name'],
      appRouteId: json['app_route_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      pivot: json['pivot'] != null ? PivotModel.fromJson(json['pivot']) : null,
    );
  }
}

class PivotModel {
  final int roleId;
  final int permissionId;

  PivotModel({
    required this.roleId,
    required this.permissionId,
  });

  factory PivotModel.fromJson(Map<String, dynamic> json) {
    return PivotModel(
      roleId: json['role_id'],
      permissionId: json['permission_id'],
    );
  }
}
