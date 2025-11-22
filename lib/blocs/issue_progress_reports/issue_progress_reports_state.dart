import 'package:flutter/cupertino.dart';

import '../../data/models/issue_progress_reports_model.dart';

@immutable
sealed class IssueProgressReportState {}

final class IssueProgressReportInitial extends IssueProgressReportState {}

final class IssueProgressReportLoading extends IssueProgressReportState {}

final class IssueProgressReportSuccess extends IssueProgressReportState {
  final String successMsg;

  IssueProgressReportSuccess({required this.successMsg});
}

final class IssueProgressReportLoaded extends IssueProgressReportState {
  final IssueProgressReportModel report;

  IssueProgressReportLoaded({required this.report});
}

final class IssueProgressReportListLoaded extends IssueProgressReportState {
  final List<IssueProgressReportModel> list;

  IssueProgressReportListLoaded({required this.list});
}

final class IssueProgressReportFail extends IssueProgressReportState {
  final String errMsg;

  IssueProgressReportFail({required this.errMsg});
}
