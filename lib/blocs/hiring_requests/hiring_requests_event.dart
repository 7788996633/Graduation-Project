

import 'package:meta/meta.dart';

@immutable
sealed class HiringRequestsEvent {}

class CreateHiringRequestsEvent extends HiringRequestsEvent {
  final String jopTitle;
  final String type;
  final String description;

  CreateHiringRequestsEvent({required this.jopTitle, required this.type, required this.description,});
}
class SetSalaryByLawyerId extends HiringRequestsEvent {
  final int lawyerId;
  final int salary;

  SetSalaryByLawyerId({
    required this.lawyerId,
    required this.salary,});
}

//class ShowHiringRequestsEvent extends HiringRequestsEvent {}

class GetAllHiringRequests extends HiringRequestsEvent {}

class GetHiringRequestsPublished extends HiringRequestsEvent {}

class GetHiringRequestsById extends HiringRequestsEvent {
  final int hiringRequestId;

  GetHiringRequestsById({required this.hiringRequestId});
}
class DeleteHiringRequest extends HiringRequestsEvent{
  final int hiringRequestId;

  DeleteHiringRequest({required this.hiringRequestId});

}
class UpdateHiringRequest extends HiringRequestsEvent{
  final String status;
  final int    hiringRequestId;

  UpdateHiringRequest({required this.status, required this. hiringRequestId});
}