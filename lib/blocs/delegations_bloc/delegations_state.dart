
import '../../data/models/delegations_model.dart';


sealed class DelegationState {}

final class DelegationInitial extends DelegationState {}

final class DelegationLoading extends DelegationState {}

final class DelegationSuccess extends DelegationState {
  final String successMsg;

  DelegationSuccess({required this.successMsg});
}

final class DelegationLoaded extends DelegationState {
  final DelegationModel delegation;

  DelegationLoaded({required this.delegation});
}

final class DelegationListLoaded extends DelegationState {
  final List<DelegationModel> list;

  DelegationListLoaded({required this.list});
}

final class DelegationFail extends DelegationState {
  final String errMsg;

  DelegationFail({required this.errMsg});
}
