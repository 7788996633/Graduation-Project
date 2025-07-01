// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'attend_demand_bloc.dart';

@immutable
sealed class AttendDemandEvent {}

class GetAllDemandByIssueEvent extends AttendDemandEvent {
  final int issueId;
  GetAllDemandByIssueEvent({
    required this.issueId,
  });
}

class GetDemandEvent extends AttendDemandEvent {
  final int idDemand;

  GetDemandEvent({required this.idDemand});
}

class UpdateDemandDateEvent extends AttendDemandEvent {
  final int idDemand;
  final String date;
  UpdateDemandDateEvent({
    required this.idDemand,
    required this.date,
  });
}

class UpdateDemandResaultEvent extends AttendDemandEvent {
  final int idDemand;
  final String resault;
  UpdateDemandResaultEvent({
    required this.idDemand,
    required this.resault,
  });
}

class DeleteDemandEvent extends AttendDemandEvent {
  final int idDemand;
  final String date;
  final String type;
  DeleteDemandEvent({
    required this.idDemand,
    required this.date,
    required this.type,
  });
}

class AddDemandEvent extends AttendDemandEvent {
  final int idIssue;
  final String date;

  AddDemandEvent({required this.idIssue, required this.date});
}
