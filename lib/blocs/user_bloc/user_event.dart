part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetAllUsers extends UserEvent {}

class GetAllClients extends UserEvent {}

class DeleteUserById extends UserEvent {
  final int userId;

  DeleteUserById({required this.userId});
}

class ChangeUserRole extends UserEvent {
  final int userId;
  final String role;

  ChangeUserRole({required this.userId, required this.role});
}

// class GetUserById extends UserEvent {
//   final int userId;

//   GetUserById({required this.userId});
// }

class GetUserRole extends UserEvent {}
