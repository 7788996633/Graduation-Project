

import 'package:meta/meta.dart';

import '../../data/models/hiring_request_model.dart';

@immutable
sealed class HiringRequestsState {}

final class HiringRequestsInitial extends HiringRequestsState {}

final class HiringRequestsLoading extends HiringRequestsState {}

final class HiringRequestsSuccess extends HiringRequestsState {
  final String successmsg;

  HiringRequestsSuccess({required this.successmsg});
}

final class HiringRequestsLoadedSuccessfully extends HiringRequestsState {
  final HiringRequestModel hiringRequestModel;

  HiringRequestsLoadedSuccessfully({required this.hiringRequestModel});
}

final class HiringRequestsFail extends HiringRequestsState {
  final String errmsg;

  HiringRequestsFail({required this.errmsg});

}


final class HiringRequestsListLoaded extends HiringRequestsState {
  late final List<HiringRequestModel> hiringRequestsList;

  HiringRequestsListLoaded({required this.hiringRequestsList});
}

final class HiringRequestsIdLoaded extends HiringRequestsState {
  final HiringRequestModel hiringRequestModel;

  HiringRequestsIdLoaded({required this.hiringRequestModel});
}