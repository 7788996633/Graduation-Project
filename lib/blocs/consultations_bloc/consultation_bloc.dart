import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../data/models/consultation_model.dart';
import '../../data/repositories/consultation_repositories.dart';
import '../../data/services/consultation_services.dart';

part 'consultation_event.dart';
part 'consultation_state.dart';

class ConsultationBloc extends Bloc<ConsultationEvent, ConsultationState> {
  ConsultationBloc() : super(ConsultationInitial()) {
    on<ConsultationEvent>(
      (event, emit) async {
        if (event is AddConsultationEvent) {
          emit(ConsultationLoading());
          try {
            String value = await ConsultationServices()
                .addConsultation(event.resault, event.consultationRequestId);
            emit(
              ConsultationSuccess(
                successmsg: value,
              ),
            );
          } catch (e) {
            emit(
              ConsultationFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetAllConsultationsEvent) {
          emit(ConsultationLoading());
          try {
            List<ConsultationModel> value =
                await ConsultationRepositories().getAllConsultations();
            emit(
              ConsultationsListLoadedSuccessfully(
                consultations: value,
              ),
            );
          } catch (e) {
            emit(
              ConsultationFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetConsultationByIdEvent) {
          emit(
            ConsultationLoading(),
          );
          try {
            ConsultationModel value =
                await ConsultationServices().getConsultationById(event.id);
            emit(
              ConsultationLoadedSuccessfully(
                consultationModel: value,
              ),
            );
          } catch (e) {
            emit(
              ConsultationFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is StartConsultationRequestReview) {
          emit(ConsultationLoading());
          try {
            String value = await ConsultationServices()
                .startConsultationRequestReview(event.consultationRequestId);
            emit(
              ConsultationSuccess(
                successmsg: value,
              ),
            );
          } catch (e) {
            emit(
              ConsultationFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is EndConsultationRequestReview) {
          emit(ConsultationLoading());
          try {
            String value = await ConsultationServices()
                .endConsultationRequestReview(event.consultationRequestId);
            emit(
              ConsultationSuccess(
                successmsg: value,
              ),
            );
          } catch (e) {
            emit(
              ConsultationFail(
                errmsg: e.toString(),
              ),
            );
          }
        }
      },
    );
  }
}
