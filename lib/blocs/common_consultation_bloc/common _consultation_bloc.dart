import 'package:bloc/bloc.dart';

import '../../data/models/common _consultation_model.dart';

import '../../data/repositories/common _consultation_repository.dart';

import '../../data/services/common _consultation_services.dart';


import 'common _consultation_event.dart';
import 'common _consultation_state.dart';

class CommonConsultationBloc extends Bloc<CommonConsultationEvent, CommonConsultationState> {
  CommonConsultationBloc() : super(CommonConsultationInitial()) {
    List<CommonConsultationModel> allConsultations = [];

    on<CommonConsultationEvent>((event, emit) async {
      if (event is GetAllCommonConsultation) {
        emit(CommonConsultationLoading());
        try {
          allConsultations = await CommonConsultationRepository().getCommonConsultations();
          emit(CommonConsultationListLoaded(commonConsultationList: allConsultations));
        } catch (e) {
          emit(CommonConsultationFail(errmsg: e.toString()));
        }
      } else if (event is CreateCommonConsultationEvent) {
        emit(CommonConsultationLoading());
        try {
          String value = await CommonConsultationServices().addCommonConsultation(
            event.question,
            event.answer,
          );
          emit(CommonConsultationSuccess(successmsg: value));
        } catch (e) {
          emit(CommonConsultationFail(errmsg: e.toString()));
        }
      } else if (event is SearchCommonConsultationsByQuestionEvent) {
        emit(CommonConsultationLoading());
        try {
          final question = event.question.trim().toLowerCase();

          final filteredList = allConsultations.where((consultation) {
            final q = consultation.question.toLowerCase();
            return q.contains(question);
          }).toList();

          emit(CommonConsultationListLoaded(commonConsultationList: filteredList));
        } catch (e) {
          emit(CommonConsultationFail(errmsg: e.toString()));
        }
      } else if (event is UpdateCommonConsultationEvent) {
        emit(CommonConsultationLoading());
        try {
          String result = await CommonConsultationServices().updateCommonConsultation(event.id, event.answer);
          emit(CommonConsultationSuccess(successmsg: result));
        } catch (e) {
          emit(CommonConsultationFail(errmsg: e.toString()));
        }
      } else if (event is DeleteCommonConsultationEvent) {
        emit(CommonConsultationLoading());
        try {
          String result = await CommonConsultationServices().deleteCommonConsultation(event.id);
          emit(CommonConsultationSuccess(successmsg: result));
        } catch (e) {
          emit(CommonConsultationFail(errmsg: e.toString()));
        }
      } else if (event is GetCommonConsultationById) {
        emit(CommonConsultationLoading());
        try {
          CommonConsultationModel consultation = await CommonConsultationServices().getCommonConsultationById(event.id);
          emit(CommonConsultationLoadedSuccessfully(consultationModel: consultation));
        } catch (e) {
          emit(CommonConsultationFail(errmsg: e.toString()));
        }
      }
    });
  }
}
