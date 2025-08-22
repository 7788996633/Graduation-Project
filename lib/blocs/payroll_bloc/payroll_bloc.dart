import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/payroll_model.dart';
import '../../data/repositories/payroll_repository.dart';
import '../../data/services/payroll_services.dart';
import 'payroll_event.dart';
part 'payroll_state.dart';

class PayrollBloc extends Bloc<PayrollEvent, PayrollState> {
  PayrollBloc() : super(PayrollInitial()) {
    List<PayrollModel> allPayrolls = [];

    on<PayrollEvent>((event, emit) async {
      if (event is AddPayrollEvent) {
        emit(PayrollLoading());
        try {
          String result = await PayrollServices()
              .addPayroll(event.description, event.employeeId, event.description);
          emit(PayrollSuccess(successMsg: result));
        } catch (e) {
          emit(PayrollFail(errMsg: e.toString()));
        }
      } else if (event is GetPayrollByIdEvent) {
        emit(PayrollLoading());
        try {
          PayrollModel payroll = await PayrollServices()
              .getPayrollById(event.payrollId);
          emit(PayrollLoaded(payroll: payroll));
        } catch (e) {
          emit(PayrollFail(errMsg: e.toString()));
        }
      } else if (event is GetAllPayrollsEvent) {
        emit(PayrollLoading());
        try {
          allPayrolls = await PayrollRepository().getPayrolls();
          emit(PayrollListLoaded(list: allPayrolls));
        } catch (e) {
          emit(PayrollFail(errMsg: e.toString()));
        }
      }
    });
  }
}
