import 'dart:core';
import 'package:bloc/bloc.dart';
import '../../data/models/job_application_model.dart';
import '../../data/repositories/job_application_repository.dart';
import '../../data/services/job_application_service.dart';

import 'job_application_event.dart';
import 'job_application_state.dart';

class JobApplicationBloc extends Bloc<JobApplicationEvent, JobApplicationState> {
  JobApplicationBloc() : super(JobApplicationInitial()) {
    on<JobApplicationEvent>((event, emit) async {
      if (event is AddJobApplicationEvent) {
        emit(JobApplicationLoading());
        try {
          String result = await JobApplicationServices()
              .addJobApplication(event.hiringReqId,event.cv);
          emit(JobApplicationSuccess(successMsg: result));
        } catch (e) {
          emit(JobApplicationFail(errMsg: e.toString()));
        }
      } else if (event is GetJobApplicationByIdEvent) {
        emit(JobApplicationLoading());
        try {
          JobApplicationModel jobApplication =
          await JobApplicationServices().getJobApplicationById(event.jobApplicationId);
          emit(JobApplicationLoaded(jobApplication: jobApplication));
        } catch (e) {
          emit(JobApplicationFail(errMsg: e.toString()));
        }
      } else if (event is GetAllJobApplicationsEvent) {
        emit(JobApplicationLoading());
        try {
          List<JobApplicationModel> data = await JobApplicationRepository().getJobApplications(event.hiringReqId);
          emit(JobApplicationListLoaded(list: data));
        } catch (e) {
          emit(JobApplicationFail(errMsg: e.toString()));
        }
      } else if (event is GetMyJobApplicationsEvent) {
        emit(JobApplicationLoading());
        try {
          List<JobApplicationModel> data = await JobApplicationRepository().getMyJobApplications();
          emit(JobApplicationListLoaded(list: data));
        } catch (e) {
          emit(JobApplicationFail(errMsg: e.toString()));
        }
      } else if (event is UpdateJobApplicationEvent) {
        emit(JobApplicationLoading());
        try {
          String result = await JobApplicationServices()
              .updateJobApplication(event.jobApplicationId, event.status);
          emit(JobApplicationSuccess(successMsg: result));
        } catch (e) {
          emit(JobApplicationFail(errMsg: e.toString()));
        }
      }
    });
  }
}
