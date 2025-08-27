import 'package:meta/meta.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardSuccess extends DashboardState {
  final int openCases;
  final int totalClients;
  final int sessionsThisMonth;
  final int totalRevenue;
  DashboardSuccess({
    required this.openCases,
    required this.totalClients,
    required this.sessionsThisMonth,
    required this.totalRevenue,
  });
}

final class DashboardFail extends DashboardState {
  final String errMsg;

  DashboardFail({required this.errMsg});
}
