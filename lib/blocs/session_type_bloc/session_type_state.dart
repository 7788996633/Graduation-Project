part of 'session_type_bloc.dart';

@immutable
sealed class SessionTypeState {}

final class SessionTypeInitial extends SessionTypeState {}

final class SessionTypeLoading extends SessionTypeState {}

final class SessionTypeSuccess extends SessionTypeState {
  final String successMsg;

  SessionTypeSuccess({required this.successMsg});
}

final class SessionTypeLoaded extends SessionTypeState {
  final SessionTypeModel session;

  SessionTypeLoaded({required this.session});
}

final class SessionTypeListLoaded extends SessionTypeState {
  final List<SessionTypeModel> list;

  SessionTypeListLoaded({required this.list});
}

final class SessionTypeFail extends SessionTypeState {
  final String errMsg;

  SessionTypeFail({required this.errMsg});
}
