import 'dart:core';
import 'package:bloc/bloc.dart';
import '../../data/models/interview_model.dart';
import '../../data/repositories/interview_repository.dart';
import '../../data/services/interview_services.dart';
import 'interview_event.dart';
import 'interviews_state.dart';

class InterviewBloc extends Bloc<InterviewEvent, InterviewState> {
  InterviewBloc() : super(InterviewInitial()) {
    on<InterviewEvent>((event, emit) async {
      if (event is AddInterviewEvent) {
        emit(InterviewLoading());
        try {
          String result = await InterviewServices()
              .addInterview(event.jobAppId,event.date,);
          emit(InterviewSuccess(successMsg: result));
        } catch (e) {
          emit(InterviewFail(errMsg: e.toString()));
        }
      } else if (event is GetInterviewByIdEvent) {
        emit(InterviewLoading());
        try {
          InterviewModel interview =
          await InterviewServices().getInterviewById(event.interviewId);
          emit(InterviewLoaded(interview: interview));
        } catch (e) {
          emit(InterviewFail(errMsg: e.toString()));
        }
      } else if (event is GetAllInterviewsEvent) {
        emit(InterviewLoading());
        try {
          List<InterviewModel> data = await InterviewRepository().getInterviews(event.jobAppId);
          emit(InterviewListLoaded(list: data));
        } catch (e) {
          emit(InterviewFail(errMsg: e.toString()));
        }
      } else if (event is UpdateInterviewEvent) {
        emit(InterviewLoading());
        try {
          String result = await InterviewServices()
              .updateInterview(event.interviewId,event.date);
          emit(InterviewSuccess(successMsg: result));
        } catch (e) {
          emit(InterviewFail(errMsg: e.toString()));
        }
      }else if (event is UpdateInterviewResultEvent) {
        emit(InterviewLoading());
        try {
          String result = await InterviewServices()
              .updateInterviewResult(event.interviewId,event.result);
          emit(InterviewSuccess(successMsg: result));
        } catch (e) {
          emit(InterviewFail(errMsg: e.toString()));
        }
      }

      else if (event is DeleteInterviewEvent) {
        emit(InterviewLoading());
        try {
          String result =
          await InterviewServices().deleteInterview(event.interviewId);
          emit(InterviewSuccess(successMsg: result));
        } catch (e) {
          emit(InterviewFail(errMsg: e.toString()));
        }
      }
    });
  }
}
