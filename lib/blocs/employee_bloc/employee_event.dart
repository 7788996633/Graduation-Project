import 'package:meta/meta.dart';

@immutable
sealed class EmployeeEvent {}

class CreateEmployeeEvent extends EmployeeEvent {
  final int userId;
  final int salary;
  final String hireDate;
  final String certificate;
  final String type;


  CreateEmployeeEvent({
    required this.userId,
    required this.salary,
    required this.hireDate,
    required this.certificate,
    required this.type,

  });
}

class GetAllEmployeesEvent extends EmployeeEvent {}

class GetEmployeeByIdEvent extends EmployeeEvent {
  final int employeeId;

  GetEmployeeByIdEvent({required this.employeeId});
}

class DeleteEmployeeEvent extends EmployeeEvent {
  final int employeeId;

  DeleteEmployeeEvent({required this.employeeId});
}

class UpdateEmployeeEvent extends EmployeeEvent {
  final int salary;
  final String certificate;
  final int employeeId;

  UpdateEmployeeEvent({
    required this.salary,
    required this.certificate,
    required this.employeeId,
  });
}
