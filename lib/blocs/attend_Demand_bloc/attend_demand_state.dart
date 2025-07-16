part of 'attend_demand_bloc.dart';

@immutable
sealed class AttendDemandState {}

final class AttendDemandInitial extends AttendDemandState {}

final class DemandSuccess extends AttendDemandState {
  final String successmsg;
  DemandSuccess({required this.successmsg});
}

final class DemandLoadedSuccessfully extends AttendDemandState {
  final DemandModel demand;

  DemandLoadedSuccessfully({required this.demand});
}

final class DemandListLoadedSuccessfully extends AttendDemandState {
  final List<DemandModel> listdemand;

  DemandListLoadedSuccessfully({required this.listdemand});
}

final class DemandLoading extends AttendDemandState {}

final class DemandFail extends AttendDemandState {
  final String errmsg;

  DemandFail({required this.errmsg});
}
