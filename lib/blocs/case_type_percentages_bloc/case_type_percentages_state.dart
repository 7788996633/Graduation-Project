import 'package:meta/meta.dart';

import '../../data/models/case_type_percentages_model.dart';

@immutable
sealed class CaseTypeState {}

final class CaseTypeInitial extends CaseTypeState {}

final class CaseTypeLoading extends CaseTypeState {}

final class CaseTypeSuccess extends CaseTypeState {
  final List<CaseTypePercentage> data;

  CaseTypeSuccess({required this.data});
}

final class CaseTypeFailure extends CaseTypeState {
  final String error;

  CaseTypeFailure({required this.error});
}
