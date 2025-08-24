import 'package:meta/meta.dart';

@immutable
sealed class SalaryAdjustmentsEvent {}

class AddSalaryAdjustmentEvent extends SalaryAdjustmentsEvent {
  final int userId;
  final String type;
  final String reason;
  final String amount;
  final String effectiveDate;

  AddSalaryAdjustmentEvent({
    required this.userId,
    required this.type,
    required this.reason,
    required this.amount,
    required this.effectiveDate,

  });
}

class GetSalaryAdjustmentByIdEvent extends SalaryAdjustmentsEvent {
  final int adjustmentId;

  GetSalaryAdjustmentByIdEvent({required this.adjustmentId});
}

class GetAllSalaryAdjustmentsEvent extends SalaryAdjustmentsEvent {
  final int userId;
  GetAllSalaryAdjustmentsEvent({required this.userId});
}

class SearchSalaryAdjustmentsByTypeEvent extends SalaryAdjustmentsEvent {
  final String type;

  SearchSalaryAdjustmentsByTypeEvent({required this.type});
}


