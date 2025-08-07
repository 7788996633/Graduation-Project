part of 'permission_bloc.dart';

@immutable
sealed class PermissionState {}

final class PermissionInitial extends PermissionState {}

final class PermissionLoading extends PermissionState {}

final class PermissionSuccess extends PermissionState {
  final String successMsg;

  PermissionSuccess({required this.successMsg});
}

final class PermissionLoaded extends PermissionState {
  final PermissionModel permission;

  PermissionLoaded({required this.permission});
}

final class PermissionListLoaded extends PermissionState {
  final List<PermissionModel> list;

  PermissionListLoaded({required this.list});
}

final class PermissionFail extends PermissionState {
  final String errMsg;

  PermissionFail({required this.errMsg});
}
