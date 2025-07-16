import 'package:meta/meta.dart';

@immutable
sealed class PermissionEvent {}

class AddPermissionEvent extends PermissionEvent {
  final String name;


  AddPermissionEvent({
    required this.name,

  });
}

class GetPermissionByIdEvent extends PermissionEvent {
  final int permissionId;

  GetPermissionByIdEvent({required this.permissionId});
}

class GetAllPermissionsEvent extends PermissionEvent {}

class UpdatePermissionEvent extends PermissionEvent {
  final int permissionId;
  final String name;

  UpdatePermissionEvent({
    required this.permissionId,
    required this.name,
  });
}

class DeletePermissionEvent extends PermissionEvent {
  final int permissionId;

  DeletePermissionEvent({
    required this.permissionId,
  });
}
