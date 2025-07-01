import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../data/models/employee_model.dart';
import '../../data/repositories/employee_repository.dart';
import '../../data/services/employee_services.dart';
part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<EmployeeEvent>(
      (event, emit) async {
        if (event is AddEmployeeEvent) {
          emit(
            EmployeeLoading(),
          );
          try {
            String value = await EmployeeServices().addEmployee(
                event.id, event.salary, event.file.path, event.type);
            emit(
              EmployeeSuccess(
                successmsg: value,
              ),
            );
          } catch (e) {
            emit(
              EmployeeFail(
                errmsg: e.toString(),
              ),
            );
          }
        }else   if (event is GetEmployeeEvent) {
          emit(
            EmployeeLoading(),
          );
          try {
            EmployeeModel value = await EmployeeServices().getEmployeeById(event.employeeId);
            emit(
           EmployeeLoadedSuccessFully(employee: value)
            );
          } catch (e) {
            emit(
              EmployeeFail(
                errmsg: e.toString(),
              ),
            );
          }
        }else   if (event is GetAllEmployeeEvent) {
          emit(
            EmployeeLoading(),
          );
          try {
          List<  EmployeeModel> value = await EmployeeRepository().getAllEmployees();
            emit(
                EmployeeListLoadedSuccessFully(employeeList: value)
            );
          } catch (e) {
            emit(
              EmployeeFail(
                errmsg: e.toString(),
              ),
            );
          }
        }
      else
        if (event is DeleteEmployeeEvent) {
          emit(
            EmployeeLoading(),
          );
          try {
            String value = await EmployeeServices().deleteEmployee(event.employeeId);
            emit(
              EmployeeSuccess(
                successmsg: value,
              ),
            );
          } catch (e) {
            emit(
              EmployeeFail(
                errmsg: e.toString(),
              ),
            );
          }
        }
      else
        if (event is EditEmployeeEvent) {
          emit(
            EmployeeLoading(),
          );
          try {
            String value = await EmployeeServices().updateEmployee(event.employeeId, event.salary, event.file.path);
            emit(
              EmployeeSuccess(
                successmsg: value,
              ),
            );
          } catch (e) {
            emit(
              EmployeeFail(
                errmsg: e.toString(),
              ),
            );
          }
        }
      },
    );
  }
}
