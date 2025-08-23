import 'dart:async';
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

    // إضافة راتب
    on<AddPayrollEvent>((event, emit) async {
      emit(PayrollLoading());
      try {
        PayrollModel payroll = await PayrollServices().addPayroll(event.userId);
        emit(PayrollLoaded(payroll: payroll)); // 🔄 بدل PayrollSuccess
      } catch (e) {
        emit(PayrollFail(errMsg: e.toString()));
      }
    });


    // الحصول على جميع الرواتب
    on<GetAllPayrollsEvent>((event, emit) async {
      emit(PayrollLoading());
      try {
        allPayrolls = await PayrollRepository().getPayrolls();
        emit(PayrollListLoaded(list: allPayrolls));
      } catch (e) {
        emit(PayrollFail(errMsg: e.toString()));
      }
    });
  }
}
