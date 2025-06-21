import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
        }
      },
    );
  }
}
