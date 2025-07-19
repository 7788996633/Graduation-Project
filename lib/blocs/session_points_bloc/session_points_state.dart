part of 'session_points_bloc.dart';

@immutable
sealed class SessionPointsState {}

final class SessionPointsInitial extends SessionPointsState {}

final class SessionPointsLoading extends SessionPointsState {}

final class SessionPointsSuccess extends SessionPointsState {
  final String successmsg;

  SessionPointsSuccess({required this.successmsg});
}

final class SessionPointsFail extends SessionPointsState {
  final String errmsg;

  SessionPointsFail({required this.errmsg});
}

final class SessionPointsListLoaded extends SessionPointsState {
  final List<SessionPointsModel> points;

  SessionPointsListLoaded({required this.points});
}

final class SessionPointLoaded extends SessionPointsState {
  final SessionPointsModel sessionPointsModel;

  SessionPointLoaded({required this.sessionPointsModel});
}
