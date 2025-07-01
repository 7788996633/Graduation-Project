part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}

class DeleteUserProfileEvent extends UserProfileEvent {
  DeleteUserProfileEvent();
}

class CreateUserProfileEvent extends UserProfileEvent {
  final String phone;
  final String address;
  final String age;
  final String scientificLevel;
  final String imagePath;
  CreateUserProfileEvent(
      {required this.phone,
      required this.address,
      required this.age,
      required this.scientificLevel,
      required this.imagePath});
}

class UpdateUserProfileEvent extends UserProfileEvent {
  final String phone;
  final String address;
  final String age;
  final String scientificLevel;
  final String imagePath;

  UpdateUserProfileEvent(
      {required this.phone,
      required this.address,
      required this.age,
      required this.scientificLevel,
      required this.imagePath});
}

class ShowUserProfileEvent extends UserProfileEvent {}

class ShowUserProfileByIdEvent extends UserProfileEvent {
  final int userId;

  ShowUserProfileByIdEvent({required this.userId});
}
