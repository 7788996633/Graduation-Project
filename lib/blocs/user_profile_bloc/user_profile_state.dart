part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

class UserProfileSuccess extends UserProfileState {
  final String successmsg;
  UserProfileSuccess({required this.successmsg});
}

class UserProfileLoadedSuccessfully extends UserProfileState {
  final UserProfileModel userProfileModel;

  UserProfileLoadedSuccessfully({required this.userProfileModel});
}

final class UserProfileLoading extends UserProfileState {}

final class UserProfileFail extends UserProfileState {
  final String errmsg;

  UserProfileFail({required this.errmsg});
}
