import '../models/role_model.dart';
import '../services/role_services.dart';

class RoleRepository {
  Future<List<RoleModel>> getRoles() async {
    var rolesList = await RoleServices().getRoles();
    return rolesList
        .map(
          (e) => RoleModel.fromJson(e),
    )
        .toList();
  }
}
