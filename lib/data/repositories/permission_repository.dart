import 'package:graduation/data/models/permission_model.dart';
import 'package:graduation/data/services/permission_services.dart';

class PermissionRepository {
  Future<List<PermissionModel>> getAllPermissions() async {
    var notificationsList = await PermissionServices().getAllPermissions();
    return notificationsList
        .map(
          (e) => PermissionModel.fromJson(e),
    )
        .toList();
  }
  Future<List<PermissionModel>> getAllPermissionsByRoleId(int Roleid) async {
    var notificationsList = await PermissionServices().getAllPermissionsByRoleId(Roleid);
    return notificationsList
        .map(
          (e) => PermissionModel.fromJson(e),
    )
        .toList();
  }

}