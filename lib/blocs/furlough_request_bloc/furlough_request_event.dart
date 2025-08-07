import 'package:meta/meta.dart';

@immutable
sealed class FurloughRequestsEvent {}

class CreateFurloughRequestsEvent extends FurloughRequestsEvent {
  final String cause;
  final String startDate;
  final String endDate;

  CreateFurloughRequestsEvent({required this.cause, required this.startDate, required this.endDate});
}

class ShowFurloughRequestsEvent extends FurloughRequestsEvent {}

class GetAllFurloughRequests extends FurloughRequestsEvent {}

class GetFurloughRequestsById extends FurloughRequestsEvent {
  final int furloughRequestId;

  GetFurloughRequestsById({required this.furloughRequestId});
}

class UpdateFurloughRequestsEvent extends FurloughRequestsEvent {
  final int furloughRequestId;
  final String cause;

  UpdateFurloughRequestsEvent({
    required this.furloughRequestId,
    required this.cause,

  });
}
class UpdateFurloughRequestsStatusEvent extends FurloughRequestsEvent {
  final int furloughRequestId;
  final String status;

  UpdateFurloughRequestsStatusEvent({
    required this.furloughRequestId,
    required this.status,

  });
}

class DeleteFurloughRequestsEvent extends FurloughRequestsEvent {
  final int furloughRequestId;

  DeleteFurloughRequestsEvent({
    required this.furloughRequestId,
  });}
