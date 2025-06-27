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
class EditEmployeeEvent extends EmployeeEvent {
  final String salary;
  final File file;
  final int employeeId;

  EditEmployeeEvent({required this.salary, required this.file, required this.employeeId});

}
class GetEmployeeEvent extends EmployeeEvent {
  final int employeeId;

  GetEmployeeEvent({required this.employeeId});


}
class DeleteEmployeeEvent extends EmployeeEvent {
  final int employeeId;

  DeleteEmployeeEvent({required this.employeeId});



}
class GetAllEmployeeEvent extends EmployeeEvent {}