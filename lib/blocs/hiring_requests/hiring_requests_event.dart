

import 'package:meta/meta.dart';

@immutable
sealed class HiringRequestsEvent {}

class CreateHiringRequestsEvent extends HiringRequestsEvent {
  final String jopTitle;
  final String type;
  final String description;

  CreateHiringRequestsEvent({required this.jopTitle, required this.type, required this.description,});
}

class ShowHiringRequestsEvent extends HiringRequestsEvent {}

class GetAllHiringRequests extends HiringRequestsEvent {}


class GetHiringRequestsById extends HiringRequestsEvent {
  final int hiringRequestId;

  GetHiringRequestsById({required this.hiringRequestId});
}