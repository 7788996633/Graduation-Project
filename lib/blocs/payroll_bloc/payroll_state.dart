part of 'payroll_bloc.dart';

@immutable
sealed class PayrollState {}

final class PayrollInitial extends PayrollState {}

final class PayrollLoading extends PayrollState {}

final class PayrollSuccess extends PayrollState {
  final String successMsg;

  PayrollSuccess({required this.successMsg});
}

final class PayrollLoaded extends PayrollState {
  final PayrollModel payroll;

  PayrollLoaded({required this.payroll});
}

final class PayrollListLoaded extends PayrollState {
  final List<PayrollModel> list;

  PayrollListLoaded({required this.list});
}

final class PayrollFail extends PayrollState {
  final String errMsg;

  PayrollFail({required this.errMsg});
}
