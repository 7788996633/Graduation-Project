import 'package:meta/meta.dart';

import '../../data/models/job_application_model.dart';

@immutable
sealed class JobApplicationState {}

final class JobApplicationInitial extends JobApplicationState {}

final class JobApplicationLoading extends JobApplicationState {}

final class JobApplicationSuccess extends JobApplicationState {
  final String successMsg;

  JobApplicationSuccess({required this.successMsg});
}

final class JobApplicationLoaded extends JobApplicationState {
  final JobApplicationModel jobApplication;

  JobApplicationLoaded({required this.jobApplication});
}

final class JobApplicationListLoaded extends JobApplicationState {
  final List<JobApplicationModel> list;

  JobApplicationListLoaded({required this.list});
}

final class JobApplicationFail extends JobApplicationState {
  final String errMsg;

  JobApplicationFail({required this.errMsg});
}
