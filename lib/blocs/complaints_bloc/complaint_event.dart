import 'package:meta/meta.dart';

@immutable
sealed class ComplaintEvent {}

class CreateComplaintEvent extends ComplaintEvent {
  final String description;

  CreateComplaintEvent({required this.description});
}

class ShowComplaintsEvent extends ComplaintEvent {}

class GetAllComplaintsEvent extends ComplaintEvent {}

class GetMyComplaintsEvent extends ComplaintEvent {}

class GetComplaintByIdEvent extends ComplaintEvent {
  final int complaintId;

  GetComplaintByIdEvent({required this.complaintId});
}

class UpdateComplaintEvent extends ComplaintEvent {
  final int complaintId;
  final String description;

  UpdateComplaintEvent({
    required this.complaintId,
    required this.description,
  });
}

class UpdateComplaintStatusEvent extends ComplaintEvent {
  final int complaintId;
  final String status;

  UpdateComplaintStatusEvent({
    required this.complaintId,
    required this.status,
  });
}

class DeleteComplaintEvent extends ComplaintEvent {
  final int complaintId;

  DeleteComplaintEvent({required this.complaintId});
}
