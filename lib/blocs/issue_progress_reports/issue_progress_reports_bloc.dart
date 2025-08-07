import 'dart:core';
import 'package:bloc/bloc.dart';

import '../../data/models/issue_progress_reports_model.dart';

import '../../data/repositories/issue_progress_reports_repository.dart';
import '../../data/services/issue_progress_reports_service.dart';

import 'issue_progress_reports_event.dart';
import 'issue_progress_reports_state.dart';

class IssueProgressReportBloc extends Bloc<IssueProgressReportEvent, IssueProgressReportState> {
  IssueProgressReportBloc() : super(IssueProgressReportInitial()) {
    List<IssueProgressReportModel> allReports = [];

    on<IssueProgressReportEvent>((event, emit) async {
      if (event is AddIssueProgressReportEvent) {
        emit(IssueProgressReportLoading());
        try {
          String result = await IssueProgressReportServices()
              .addReport(event.report, );
          emit(IssueProgressReportSuccess(successMsg: result));
        } catch (e) {
          emit(IssueProgressReportFail(errMsg: e.toString()));
        }
      }
      else if (event is GetIssueProgressReportByIdEvent) {
        emit(IssueProgressReportLoading());
        try {
          IssueProgressReportModel report = await IssueProgressReportServices()
              .getReportById(event.reportId);
          emit(IssueProgressReportLoaded(report: report));
        } catch (e) {
          emit(IssueProgressReportFail(errMsg: e.toString()));
        }
      }

      else if (event is GetIssueProgressReportByIdEvent) {
        emit(IssueProgressReportLoading());
        try {
          IssueProgressReportModel report = await IssueProgressReportServices()
              .getReportByIssueId(event.reportId);
          emit(IssueProgressReportLoaded(report: report));
        } catch (e) {
          emit(IssueProgressReportFail(errMsg: e.toString()));
        }
      }
      else if (event is GetAllIssueProgressReportsEvent) {
        emit(IssueProgressReportLoading());
        try {
          allReports = await IssueProgressReportRepository().getIssueProgressReports();
          emit(IssueProgressReportListLoaded(list: allReports));
        } catch (e) {
          emit(IssueProgressReportFail(errMsg: e.toString()));
        }
      }
      else if (event is UpdateIssueProgressReportEvent) {
        emit(IssueProgressReportLoading());
        try {
          String result = await IssueProgressReportServices()
              .updateReport(event.reportId, event.report, );
          emit(IssueProgressReportSuccess(successMsg: result));
        } catch (e) {
          emit(IssueProgressReportFail(errMsg: e.toString()));
        }
      }
      else if (event is DeleteIssueProgressReportEvent) {
        emit(IssueProgressReportLoading());
        try {
          String result = await IssueProgressReportServices()
              .deleteReport(event.reportId);
          emit(IssueProgressReportSuccess(successMsg: result));
        } catch (e) {
          emit(IssueProgressReportFail(errMsg: e.toString()));
        }
      }
    });
  }
}
