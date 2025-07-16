import 'package:meta/meta.dart';

import '../../data/models/employee_model.dart';

@immutable
sealed class EmployeeState {}

final class EmployeeInitial extends EmployeeState {}

final class EmployeeLoading extends EmployeeState {}

final class EmployeeSuccess extends EmployeeState {
  final String successMsg;

  EmployeeSuccess({required this.successMsg});
}

final class EmployeeLoadedSuccessfully extends EmployeeState {
  final EmployeeModel employeeModel;

  EmployeeLoadedSuccessfully({required this.employeeModel});
}

final class EmployeeFail extends EmployeeState {
  final String errMsg;

  EmployeeFail({required this.errMsg});
}

final class EmployeeListLoaded extends EmployeeState {
  final List<EmployeeModel> employeeList;

  EmployeeListLoaded({required this.employeeList});
}

final class EmployeeIdLoaded extends EmployeeState {
  final EmployeeModel employeeModel;

  EmployeeIdLoaded({required this.employeeModel});
}