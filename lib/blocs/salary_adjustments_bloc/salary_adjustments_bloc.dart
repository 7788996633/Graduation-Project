import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/salary_adjustments_model.dart';
import '../../data/repositories/salary_adjustments_repository.dart';
import '../../data/services/salary_adjustments_services.dart';
import 'salary_adjustments_event.dart';
part 'salary_adjustments_state.dart';

class SalaryAdjustmentsBloc extends Bloc<SalaryAdjustmentsEvent, SalaryAdjustmentsState> {
  SalaryAdjustmentsBloc() : super(SalaryAdjustmentsInitial()) {
    List<SalaryAdjustment> allSalaryAdjustments = [];

    on<SalaryAdjustmentsEvent>((event, emit) async {
      if (event is AddSalaryAdjustmentEvent) {
        emit(SalaryAdjustmentsLoading());
        try {
          String result = await SalaryAdjustmentServices()
              .addSalaryAdjustment(event.type, event.points, event.description);
          emit(SalaryAdjustmentsSuccess(successMsg: result));
        } catch (e) {
          emit(SalaryAdjustmentsFail(errMsg: e.toString()));
        }
      } else if (event is GetSalaryAdjustmentByIdEvent) {
        emit(SalaryAdjustmentsLoading());
        try {
          SalaryAdjustment adjustment = await SalaryAdjustmentServices()
              .getSalaryAdjustmentById(event.adjustmentId);
          emit(SalaryAdjustmentsLoaded(adjustment: adjustment));
        } catch (e) {
          emit(SalaryAdjustmentsFail(errMsg: e.toString()));
        }
      } else if (event is GetAllSalaryAdjustmentsEvent) {
        emit(SalaryAdjustmentsLoading());
        try {
          allSalaryAdjustments = await SalaryAdjustmentRepository().getSalaryAdjustments();
          emit(SalaryAdjustmentsListLoaded(list: allSalaryAdjustments));
        } catch (e) {
          emit(SalaryAdjustmentsFail(errMsg: e.toString()));
        }
      } else if (event is SearchSalaryAdjustmentsByTypeEvent) {
        emit(SalaryAdjustmentsLoading());
        try {
          final typeLower = event.type.trim().toLowerCase();
          final filteredList = allSalaryAdjustments.where((adjustment) {
            final type = adjustment.type.toLowerCase();
            return type.contains(typeLower);
          }).toList();

          emit(SalaryAdjustmentsListLoaded(list: filteredList));
        } catch (e) {
          emit(SalaryAdjustmentsFail(errMsg: e.toString()));
        }

      }
    });
  }
}


