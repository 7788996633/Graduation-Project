import 'package:bloc/bloc.dart';
import '../../data/models/employee_model.dart';
import '../../data/repositories/employee_repository.dart';
import '../../data/services/employee_services.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<CreateEmployeeEvent>((event, emit) async {
      emit(EmployeeLoading());
      try {
        String value = await EmployeeServices().createEmployee(
          event.userId,
          event.salary,
          event.hireDate,
          event.certificate,
          event.certificateFileName,
          event.type,

        );
        emit(EmployeeSuccess(successMsg: value));
      } catch (e) {
        emit(EmployeeFail(errMsg: e.toString()));
      }
    });

    on<GetAllEmployeesEvent>((event, emit) async {
      emit(EmployeeLoading());
      try {
        List<EmployeeModel> employeeList = await EmployeeRepository().getEmployees();
        emit(EmployeeListLoaded(employeeList: employeeList));
      } catch (e) {
        emit(EmployeeFail(errMsg: e.toString()));
      }
    });

    on<GetEmployeeByIdEvent>((event, emit) async {
      emit(EmployeeLoading());
      try {
        EmployeeModel employee = await EmployeeServices().getEmployeeById(event.employeeId);
        emit(EmployeeIdLoaded(employeeModel: employee));
      } catch (e) {
        emit(EmployeeFail(errMsg: e.toString()));
      }
    });

    on<DeleteEmployeeEvent>((event, emit) async {
      emit(EmployeeLoading());
      try {
        String result = await EmployeeServices().deleteEmployee(event.employeeId);
        emit(EmployeeSuccess(successMsg: result));
      } catch (e) {
        emit(EmployeeFail(errMsg: e.toString()));
      }
    });

    on<UpdateEmployeeEvent>((event, emit) async {
      emit(EmployeeLoading());
      try {
        String result = await EmployeeServices().updateEmployee(event.salary,event.certificate, event.employeeId);
        emit(EmployeeSuccess(successMsg: result));
      } catch (e) {
        emit(EmployeeFail(errMsg: e.toString()));
      }
    });
  }
}