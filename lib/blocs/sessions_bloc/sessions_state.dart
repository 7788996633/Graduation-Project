

import 'package:meta/meta.dart';

import '../../data/models/session_model.dart';

@immutable
sealed class SessionsState {}

final class SessionsInitial extends SessionsState {}

final class SessionsSuccess extends SessionsState {
  final String successmsg;

  SessionsSuccess({required this.successmsg});
}


final class SessionsLoading extends SessionsState {}

final class SessionsFail extends SessionsState {
  final String errmsg;

  SessionsFail({required this.errmsg});
}

final class SessionsListLoaded extends SessionsState {
  final List<SessionModel> sessionsList;
  SessionsListLoaded({required this.sessionsList});
}


final class SessionLoadedSuccessfully extends SessionsState {
  final SessionModel session;
  SessionLoadedSuccessfully({required this.session});
}