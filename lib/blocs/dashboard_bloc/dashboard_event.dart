import 'package:meta/meta.dart';

@immutable
sealed class DashboardEvent {}

class FetchDashboardData extends DashboardEvent {}
