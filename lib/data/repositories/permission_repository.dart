import '../models/permission_model.dart';

import '../services/permission_services.dart';

class PermissionRepository {
  Future<List<PermissionModel>> getPermissions() async {
    var permissionsList = await PermissionServices().getPermissions();
    return permissionsList
        .map(
          (e) => PermissionModel.fromJson(e),
    )
        .toList();
  }
}
