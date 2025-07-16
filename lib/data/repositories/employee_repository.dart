import '../models/employee_model.dart';
import '../services/employee_services.dart';

class EmployeeRepository {
  Future<List<EmployeeModel>> getEmployees() async {
    var employeeList = await EmployeeServices().getEmployees();
    return employeeList
        .map(
          (e) => EmployeeModel.fromJson(e),
    )
        .toList();
  }
}