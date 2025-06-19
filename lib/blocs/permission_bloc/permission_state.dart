part of 'permission_bloc.dart';

@immutable
sealed class PermissionState {}

final class PermissionInitial extends PermissionState {}
final class  PermissionAddedSuccessfully extends  PermissionState{
  final String successmsg;

  PermissionAddedSuccessfully({required this.successmsg});

}
final class  AssignPermissionSuccessfully extends  PermissionState{
  final String successmsg;

  AssignPermissionSuccessfully({required this.successmsg});

}
final class PermissionLoading extends PermissionState {}
final class RoleLoading extends PermissionState {}

final class RoleFail extends PermissionState {
  final String errmsg;

  RoleFail({required this.errmsg});
}
final class PermissionFail extends PermissionState {
  final String errmsg;

  PermissionFail({required this.errmsg});
}
final class  RoleAddedSuccessfully extends  PermissionState{
  final String successmsg;

  RoleAddedSuccessfully({required this.successmsg});

}
final class  PermissionsAssignSuccessfully extends  PermissionState{
  final String successmsg;

  PermissionsAssignSuccessfully({required this.successmsg});

}
final class  getAllPermissionsSuccessfully extends  PermissionState{
  final List<PermissionModel> permissions;

  getAllPermissionsSuccessfully({required this.permissions});

}
final class  getAllPermissionsByRoleIdSuccessfully extends  PermissionState{
  final List<PermissionModel> permissions;

  getAllPermissionsByRoleIdSuccessfully({required this.permissions});

}