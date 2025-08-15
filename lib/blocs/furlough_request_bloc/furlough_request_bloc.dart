import 'package:bloc/bloc.dart';
import '../../data/models/furlough_request_model.dart';
import '../../data/repositories/furlough_request_repository.dart';
import '../../data/services/furlough_request_services.dart';
import 'furlough_request_event.dart';
import 'furlough_request_state.dart';

class FurloughRequestsBloc extends Bloc<FurloughRequestsEvent, FurloughRequestsState> {
  FurloughRequestsBloc() : super(FurloughRequestsInitial()) {
    on<FurloughRequestsEvent>((event, emit) async {
      if (event is CreateFurloughRequestsEvent) {
        emit(FurloughRequestsLoading());
        try {
          String value = await FurloughRequestsServices().addFurloughRequest(
            event.cause,
            event.startDate,
            event.endDate,

          );
          emit(FurloughRequestsSuccess(successmsg: value));
        } catch (e) {
          emit(FurloughRequestsFail(errmsg: e.toString()));
        }
      }
      if (event is GetAllFurloughRequests) {
        emit(FurloughRequestsLoading());
        try {
          List<FurloughRequestModel> furloughRequestsList =
          await FurloughRequestRepository().furloughRequests();
          emit(FurloughRequestsListLoaded(furloughRequestsList: furloughRequestsList));
        } catch (e) {
          emit(FurloughRequestsFail(errmsg: e.toString()));
        }
      }
      else if (event is GetMyFurloughRequests) {
        emit(FurloughRequestsLoading());
        try {
          List<FurloughRequestModel> furloughRequestsList =
          await FurloughRequestRepository().furloughRequests();
          emit(FurloughRequestsListLoaded(furloughRequestsList: furloughRequestsList));
        } catch (e) {
          emit(FurloughRequestsFail(errmsg: e.toString()));
        }
      }
      else if (event is UpdateFurloughRequestsEvent) {
        emit(FurloughRequestsLoading());
        try {
          String result = await FurloughRequestsServices()
              .updateFurloughRequest(event.furloughRequestId,event.cause);
          emit(FurloughRequestsSuccess(successmsg: result));
        } catch (e) {
          emit(FurloughRequestsFail(errmsg: e.toString()));
        }
      }
      else if (event is UpdateFurloughRequestsStatusEvent) {
        emit(FurloughRequestsLoading());
        try {
          String result = await FurloughRequestsServices()
              .updateFurloughRequestStatus(event.furloughRequestId,event.status);
          emit(FurloughRequestsSuccess(successmsg: result));
        } catch (e) {
          emit(FurloughRequestsFail(errmsg: e.toString()));
        }
      }
      else if (event is DeleteFurloughRequestsEvent) {
        emit(FurloughRequestsLoading());
        try {
          String result =
          await FurloughRequestsServices().deleteFurloughRequest(event.furloughRequestId);
          emit(FurloughRequestsSuccess(successmsg: result));
        } catch (e) {
          emit(FurloughRequestsFail(errmsg: e.toString()));
        }
      }
      else if (event is GetFurloughRequestsById) {
        emit(FurloughRequestsLoading());
        try {
          FurloughRequestModel furloughRequestId =
          await FurloughRequestsServices().getFurloughRequestById(event.furloughRequestId);

          emit(FurloughRequestsLoadedSuccessfully(furloughRequestModel: furloughRequestId));
        } catch (e) {
          emit(FurloughRequestsFail(errmsg: e.toString()));
        }
      }
    });
  }
}
