
import '../models/employee_model.dart';
import '../services/employee_services.dart';

class EmployeeRepository {
  Future<List<EmployeeModel>>getAllEmployees()async{
    var employeesList = await EmployeeServices ().getAllEmployee();
    return  employeesList
        .map(
          (e) => EmployeeModel.fromJson(e),)
        .toList();
  }
}