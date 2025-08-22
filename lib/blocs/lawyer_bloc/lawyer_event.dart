import 'package:meta/meta.dart';

import '../../data/filters/filters_strategy.dart';
import '../../data/models/lawyer_model.dart';

@immutable
sealed class LawyerEvent {}

class GetAllLawyersEvent extends LawyerEvent {}

class DeleteLawyerByIdEvent extends LawyerEvent {
  final int lawyerId;

  DeleteLawyerByIdEvent({required this.lawyerId});
}

class GetLawyerByIdEvent extends LawyerEvent {
  final int lawyerId;

  GetLawyerByIdEvent({required this.lawyerId});
}

class SearchLawyersByNameEvent extends LawyerEvent {
  final String name;

  SearchLawyersByNameEvent({required this.name});
}

class FilterLawyers extends LawyerEvent {
  final FiltersStrategy<LawyerModel> filter;

  FilterLawyers(this.filter);
}