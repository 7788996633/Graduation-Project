part of 'role_bloc.dart';

@immutable
sealed class RoleState {}

final class RoleInitial extends RoleState {}

final class RoleLoading extends RoleState {}

final class RoleSuccess extends RoleState {
  final String successMsg;

  RoleSuccess({required this.successMsg});
}

final class RoleLoaded extends RoleState {
  final RoleModel role;

  RoleLoaded({required this.role});
}

final class RoleListLoaded extends RoleState {
  final List<RoleModel> list;

  RoleListLoaded({required this.list});
}

final class RoleFail extends RoleState {
  final String errMsg;

  RoleFail({required this.errMsg});
}
