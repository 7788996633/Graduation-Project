part of 'permission_bloc.dart';

@immutable
sealed class PermissionEvent {}
class AddPermissionEvent extends PermissionEvent {
  final int RoleId;
  final  String name;

  AddPermissionEvent({required this.RoleId, required this.name});
}

class GetAllPermissionEvent extends PermissionEvent {}

class GetAllPermissionByRoleIdEvent extends PermissionEvent {
  final int RoleId;

  GetAllPermissionByRoleIdEvent({required this.RoleId});
}

class AddNewRoleEvent extends PermissionEvent {
  final  String name;

  AddNewRoleEvent({required this.name});
}

class AssignPermissions extends PermissionEvent {
  final int RoleId;
  final int PermissionsId;

  AssignPermissions({required this.RoleId, required this.PermissionsId});


}