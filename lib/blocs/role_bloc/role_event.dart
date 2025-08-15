import 'package:meta/meta.dart';

@immutable
sealed class RoleEvent {}

class AddRoleEvent extends RoleEvent {
  final String name;

  AddRoleEvent({
    required this.name,
  });
}

class GetRoleByIdEvent extends RoleEvent {
  final int roleId;

  GetRoleByIdEvent({required this.roleId});
}

class GetAllRolesEvent extends RoleEvent {}

class UpdateRoleEvent extends RoleEvent {
  final int roleId;
  final String name;

  UpdateRoleEvent({
    required this.roleId,
    required this.name,
  });
}

class DeleteRoleEvent extends RoleEvent {
  final int roleId;

  DeleteRoleEvent({
    required this.roleId,
  });
}
