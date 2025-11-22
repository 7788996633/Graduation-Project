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


