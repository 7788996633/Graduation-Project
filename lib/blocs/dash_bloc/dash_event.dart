import 'package:meta/meta.dart';

@immutable
sealed class DashEvent {}
class GetMonthlyRevenues extends DashEvent {}
class GetMonthlyCosts extends DashEvent {}
