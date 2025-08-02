import 'dart:io';

import 'package:meta/meta.dart';

@immutable
sealed class JobApplicationEvent {}
class AddJobApplicationEvent extends JobApplicationEvent {
  final int hiringReqId;
  final File cv;

  AddJobApplicationEvent({
    required this.hiringReqId,
    required this.cv,
  });
}

class GetJobApplicationByIdEvent extends JobApplicationEvent {
  final int jobApplicationId;

  GetJobApplicationByIdEvent({required this.jobApplicationId});
}

class GetAllJobApplicationsEvent extends JobApplicationEvent {
  final int hiringReqId;

  GetAllJobApplicationsEvent({required this.hiringReqId});
}
class GetMyJobApplicationsEvent extends JobApplicationEvent {}

class UpdateJobApplicationEvent extends JobApplicationEvent {
  final int jobApplicationId;
  final String date;

  UpdateJobApplicationEvent({
    required this.jobApplicationId,
    required this.date,
  });
}

class DeleteJobApplicationEvent extends JobApplicationEvent {
  final int jobApplicationId;

  DeleteJobApplicationEvent({
    required this.jobApplicationId,
  });
}
