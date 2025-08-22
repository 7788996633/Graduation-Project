import 'package:meta/meta.dart';

@immutable
sealed class PayrollEvent {}

class AddPayrollEvent extends PayrollEvent {
  final double salary;
  final int employeeId;
  final String description;

  AddPayrollEvent({
    required this.salary,
    required this.employeeId,
    required this.description,
  });
}

class GetPayrollByIdEvent extends PayrollEvent {
  final int payrollId;

  GetPayrollByIdEvent({required this.payrollId});
}

class GetAllPayrollsEvent extends PayrollEvent {}

class SearchPayrollsByEmployeeEvent extends PayrollEvent {
  final String employeeName;

  SearchPayrollsByEmployeeEvent({required this.employeeName});
}

class UpdatePayrollEvent extends PayrollEvent {
  final int payrollId;
  final double salary;

  UpdatePayrollEvent({
    required this.payrollId,
    required this.salary,
  });
}

class DeletePayrollEvent extends PayrollEvent {
  final int payrollId;

  DeletePayrollEvent({required this.payrollId});
}
