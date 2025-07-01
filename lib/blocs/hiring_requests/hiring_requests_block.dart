import 'package:bloc/bloc.dart';
import '../../data/models/hiring_request_model.dart';
import '../../data/repositories/hiring_request_repository.dart';
import '../../data/services/hiring_requests_services.dart';
import 'hiring_requests_event.dart';
import 'hiring_requests_state.dart';

class HiringRequestsBloc
    extends Bloc<HiringRequestsEvent, HiringRequestsState> {
  HiringRequestsBloc() : super(HiringRequestsInitial()) {
    on<HiringRequestsEvent>((event, emit) async {
      if (event is CreateHiringRequestsEvent) {
        emit(
          HiringRequestsLoading(),
        );
        try {
          String value = await HiringRequestsServices().creatHiringRequests(
            event.jopTitle,
            event.type,
            event.description,
          );
          emit(
            HiringRequestsSuccess(successmsg: value),
          );
        } catch (e) {
          emit(
            HiringRequestsFail(
              errmsg: e.toString(),
            ),
          );
        }
      }
      if (event is GetAllHiringRequests) {
        emit(HiringRequestsLoading());
        try {
          List<HiringRequestModel> hiringRequestsList =
              await HiringRequestRepository().getHiringRequests();
          emit(
              HiringRequestsListLoaded(hiringRequestsList: hiringRequestsList));
        } catch (e) {
          emit(
            HiringRequestsFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is GetHiringRequestsById) {
        emit(
          HiringRequestsLoading(),
        );
        try {
          HiringRequestModel hiringRequestId =
              await HiringRequestsServices().getHiringRequestById(
            event.hiringRequestId,
          );

          emit(
            HiringRequestsLoadedSuccessfully(
              hiringRequestModel: hiringRequestId,
            ),
          );
        } catch (e) {
          emit(HiringRequestsFail(errmsg: e.toString()));
        }
      }
    });
  }
}
