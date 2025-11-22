import 'package:meta/meta.dart';

@immutable
sealed class DashboardEvent {}

class FetchDashboardData extends DashboardEvent {}
class GetMonthlyRevenues extends DashboardEvent {}
class GetMonthlyCosts extends DashboardEvent {}