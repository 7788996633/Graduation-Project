part of 'employee_bloc.dart';

@immutable
sealed class EmployeeEvent {}

class AddEmployeeEvent extends EmployeeEvent {
  final String salary;
  final int id;
  final File file;
  final String type;

  AddEmployeeEvent(
      {required this.salary,
      required this.id,
      required this.file,
      required this.type});
}
