import 'package:meta/meta.dart';

import '../../data/models/lawyer_model.dart';

@immutable
sealed class LawyerState {}

final class LawyerInitial extends LawyerState {}

final class LawyerSuccess extends LawyerState {
  final String successMsg;

  LawyerSuccess({required this.successMsg});
}

final class LawyerLoading extends LawyerState {}

final class LawyerFail extends LawyerState {
  final String errorMsg;

  LawyerFail({required this.errorMsg});
}

final class LawyersListLoaded extends LawyerState {
  final List<LawyerModel> lawyersList;

  LawyersListLoaded({required this.lawyersList});
}

final class LawyerLoadedSuccessfully extends LawyerState {
  final LawyerModel lawyerModel;

  LawyerLoadedSuccessfully({required this.lawyerModel});
}
