import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/demand_model.dart';
import '../../data/repositories/demand_repository.dart';
import '../../data/services/demand_services.dart';

part 'attend_demand_event.dart';
part 'attend_demand_state.dart';

class AttendDemandBloc extends Bloc<AttendDemandEvent, AttendDemandState> {
  AttendDemandBloc() : super(AttendDemandInitial()) {
    on<AttendDemandEvent>((event, emit) async {
      if (event is AddDemandEvent) {
        emit(
          DemandLoading(),
        );
        try {
          String value =
              await DemandServices().addDemand(event.idIssue, event.date);

          emit(DemandSuccess(successmsg: value));
        } catch (e) {
          emit(
            DemandFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is GetDemandEvent) {
        emit(
          DemandLoading(),
        );
        try {
          DemandModel value = await DemandServices().getDemand(event.idDemand);

          emit(
            DemandLoadedSuccessfully(demand: value),
          );
        } catch (e) {
          emit(
            DemandFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is GetAllDemandByIssueEvent) {
        emit(
          DemandLoading(),
        );
        try {
          List<DemandModel> value =
              await DemandRepository().getAllDemands(event.issueId);

          emit(
            DemandListLoadedSuccessfully(listdemand: value),
          );
        } catch (e) {
          emit(
            DemandFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is UpdateDemandDateEvent) {
        emit(
          DemandLoading(),
        );
        try {
          String value =
              await DemandServices().updateDemand(event.idDemand, event.date);
          emit(DemandSuccess(successmsg: value));
        } catch (e) {
          emit(
            DemandFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is UpdateDemandResaultEvent) {
        emit(
          DemandLoading(),
        );
        try {
          String value = await DemandServices()
              .updateDemandResault(event.idDemand, event.resault);
          emit(DemandSuccess(successmsg: value));
        } catch (e) {
          emit(
            DemandFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is DeleteDemandEvent) {
        emit(
          DemandLoading(),
        );
        try {
          String value = await DemandServices()
              .deleteDemand(event.idDemand, event.date, event.date);
          emit(DemandSuccess(successmsg: value));
        } catch (e) {
          emit(
            DemandFail(
              errmsg: e.toString(),
            ),
          );
        }
      }
    });
  }
}
