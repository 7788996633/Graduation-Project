part of 'employee_bloc.dart';

@immutable
sealed class EmployeeState {}

final class EmployeeInitial extends EmployeeState {}

final class EmployeeLoading extends EmployeeState {}

final class EmployeeSuccess extends EmployeeState {
  final String successmsg;

  EmployeeSuccess({required this.successmsg});
}
final class EmployeeLoadedSuccessFully extends EmployeeState{
  final EmployeeModel employee;

  EmployeeLoadedSuccessFully({required this.employee});

}
final class EmployeeListLoadedSuccessFully extends EmployeeState{
  final List<EmployeeModel> employeeList;

  EmployeeListLoadedSuccessFully({required this.employeeList});


}
final class EmployeeFail extends EmployeeState {
  final String errmsg;

  EmployeeFail({required this.errmsg});
}
