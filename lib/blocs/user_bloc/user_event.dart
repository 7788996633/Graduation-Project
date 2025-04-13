part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetAllUsers extends UserEvent {}

class DeleteUserById extends UserEvent {
  final int userId;

  DeleteUserById({required this.userId});
}

// class GetUserById extends UserEvent {
//   final int userId;

//   GetUserById({required this.userId});
// }

// class GetUserRole extends UserEvent {
//   final int groupId;

//   GetUserRole({required this.groupId});
// }
