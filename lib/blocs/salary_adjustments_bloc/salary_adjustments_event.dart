import 'package:meta/meta.dart';

@immutable
sealed class SalaryAdjustmentsEvent {}

class AddSalaryAdjustmentEvent extends SalaryAdjustmentsEvent {
  final String type;
  final int points;
  final String description;

  AddSalaryAdjustmentEvent({
    required this.type,
    required this.points,
    required this.description,
  });
}

class GetSalaryAdjustmentByIdEvent extends SalaryAdjustmentsEvent {
  final int adjustmentId;

  GetSalaryAdjustmentByIdEvent({required this.adjustmentId});
}

class GetAllSalaryAdjustmentsEvent extends SalaryAdjustmentsEvent {}

class SearchSalaryAdjustmentsByTypeEvent extends SalaryAdjustmentsEvent {
  final String type;

  SearchSalaryAdjustmentsByTypeEvent({required this.type});
}


