import 'package:meta/meta.dart';

@immutable
sealed class DashState {}

final class DashInitial extends DashState {}

final class DashLoading extends DashState {}

final class DashSuccess extends DashState {
  final int openCases;
  final int totalClients;
  final int sessionsThisMonth;

  DashSuccess({
    required this.openCases,
    required this.totalClients,
    required this.sessionsThisMonth,
  });
}

final class DashFail extends DashState {
  final String errMsg;

  DashFail({required this.errMsg});
}
