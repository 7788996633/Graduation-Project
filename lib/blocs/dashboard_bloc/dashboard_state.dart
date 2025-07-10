import 'package:meta/meta.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardSuccess extends DashboardState {
  final int openCases;
  final int totalClients;
  final int sessionsThisMonth;

  DashboardSuccess({
    required this.openCases,
    required this.totalClients,
    required this.sessionsThisMonth,
  });
}

final class DashboardFailure extends DashboardState {
  final String error;

  DashboardFailure({required this.error});
}
