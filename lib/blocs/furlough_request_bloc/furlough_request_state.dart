import 'package:meta/meta.dart';

import '../../data/models/furlough_request_model.dart';

@immutable
sealed class FurloughRequestsState {}

final class FurloughRequestsInitial extends FurloughRequestsState {}

final class FurloughRequestsLoading extends FurloughRequestsState {}

final class FurloughRequestsSuccess extends FurloughRequestsState {
  final String successmsg;

  FurloughRequestsSuccess({required this.successmsg});
}

final class FurloughRequestsLoadedSuccessfully extends FurloughRequestsState {
  final FurloughRequestModel furloughRequestModel;

  FurloughRequestsLoadedSuccessfully({required this.furloughRequestModel});
}

final class FurloughRequestsFail extends FurloughRequestsState {
  final String errmsg;

  FurloughRequestsFail({required this.errmsg});
}

final class FurloughRequestsListLoaded extends FurloughRequestsState {
  late final List<FurloughRequestModel> furloughRequestsList;

  FurloughRequestsListLoaded({required this.furloughRequestsList});
}

final class FurloughRequestsIdLoaded extends FurloughRequestsState {
  final FurloughRequestModel furloughRequestModel;

  FurloughRequestsIdLoaded({required this.furloughRequestModel});
}
