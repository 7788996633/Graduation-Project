import 'package:graduation/data/services/employee_services.dart';

import '../models/employee_model.dart';

class EmployeeRepository {
  Future<List<EmployeeModel>>getAllEmployees()async{
    var employeesList = await EmployeeServices ().getAllEmployee();
    return  employeesList
        .map(
          (e) => EmployeeModel.fromJson(e),)
        .toList();
  }
}