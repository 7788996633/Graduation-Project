import 'package:meta/meta.dart';
import '../../data/models/dash_model.dart';

@immutable
sealed class DashState {}

final class DashInitial extends DashState {}

final class DashLoading extends DashState {}

final class DashSuccess extends DashState {
  final List<DashCount> monthlyData;

  DashSuccess({required this.monthlyData});
}

final class DashFail extends DashState {
  final String errMsg;

  DashFail({required this.errMsg});
}
