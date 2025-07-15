
import 'package:meta/meta.dart';

import '../../data/models/interview_model.dart';

@immutable
sealed class InterviewState {}

final class InterviewInitial extends InterviewState {}

final class InterviewLoading extends InterviewState {}

final class InterviewSuccess extends InterviewState {
  final String successMsg;

  InterviewSuccess({required this.successMsg});
}

final class InterviewLoaded extends InterviewState {
  final InterviewModel interview;

  InterviewLoaded({required this.interview});
}

final class InterviewListLoaded extends InterviewState {
  final List<InterviewModel> list;

  InterviewListLoaded({required this.list});
}

final class InterviewFail extends InterviewState {
  final String errMsg;

  InterviewFail({required this.errMsg});
}
