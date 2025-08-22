part of 'salary_adjustments_bloc.dart';

@immutable
sealed class SalaryAdjustmentsState {}

final class SalaryAdjustmentsInitial extends SalaryAdjustmentsState {}

final class SalaryAdjustmentsLoading extends SalaryAdjustmentsState {}

final class SalaryAdjustmentsSuccess extends SalaryAdjustmentsState {
  final String successMsg;

  SalaryAdjustmentsSuccess({required this.successMsg});
}

final class SalaryAdjustmentsLoaded extends SalaryAdjustmentsState {
  final SalaryAdjustment adjustment;

  SalaryAdjustmentsLoaded({required this.adjustment});
}

final class SalaryAdjustmentsListLoaded extends SalaryAdjustmentsState {
  final List<SalaryAdjustment> list;

  SalaryAdjustmentsListLoaded({required this.list});
}



final class SalaryAdjustmentsFail extends SalaryAdjustmentsState {
  final String errMsg;

  SalaryAdjustmentsFail({required this.errMsg});
}
