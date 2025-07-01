import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../data/models/consultation_Request_model.dart';
import '../../data/repositories/consultation_request_repository.dart';
import '../../data/services/consultation_request_services.dart';


part 'consultation_request_event.dart';
part 'consultation_request_state.dart';

class ConsultationRequestBloc
    extends Bloc<ConsultationRequestEvent, ConsultationRequestState> {
  ConsultationRequestBloc() : super(ConsultationRequestInitial()) {
    on<ConsultationRequestEvent>((event, emit) async {
      if (event is AddConsultationRequestEvent) {
        emit(
          ConsultationRequestLoading(),
        );
        try {
          String value = await ConsultationRequestServices()
              .addConsultationRequest(event.subject, event.details);
          emit(
            ConsultationRequestSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            ConsultationRequestFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is UpdateConsultationRequestEvent) {
        emit(
          ConsultationRequestLoading(),
        );
        try {
          String value = await ConsultationRequestServices()
              .updateConsultationRequest(event.subject, event.id);
          emit(
            ConsultationRequestSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            ConsultationRequestFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is GetConsultationRequestStatusEvent) {
        emit(
          ConsultationRequestLoading(),
        );
        try {
          ConsultationRequestModel value = await ConsultationRequestServices()
              .getConsultationRequest(event.id);
          emit(
            ConsultationRequestSuccessFully(
              consultationRequest: value,
            ),
          );
        } catch (e) {
          emit(
            ConsultationRequestFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is GetAllConsultationRequestStatusEvent) {
        emit(
          ConsultationRequestLoading(),
        );
        try {
          List<ConsultationRequestModel> value =
              await ConsultationRequestRepository().getALLConsultationRequest();
          emit(ConsultationRequestListLoadedSuccessFully(
              consultationRequest: value));
        } catch (e) {
          emit(
            ConsultationRequestFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is DeleteConsultationRequestStatusEvent) {
        emit(
          ConsultationRequestLoading(),
        );
        try {
          String value = await ConsultationRequestServices()
              .deleteConsultationRequest(event.id);
          emit(ConsultationRequestSuccess(successmsg: value));
        } catch (e) {
          emit(
            ConsultationRequestFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is UpdateConsultationRequestStatusEvent) {
        emit(
          ConsultationRequestLoading(),
        );
        try {
          String value = await ConsultationRequestServices()
              .updateConsultationRequestStatus(event.id, event.status);
          emit(
            ConsultationRequestSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            ConsultationRequestFail(
              errmsg: e.toString(),
            ),
          );
        }
      }
    });
  }
}
