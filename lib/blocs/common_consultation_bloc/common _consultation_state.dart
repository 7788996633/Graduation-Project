import 'package:meta/meta.dart';

import '../../data/models/common _consultation_model.dart';


@immutable
sealed class CommonConsultationState {}

final class CommonConsultationInitial extends CommonConsultationState {}

final class CommonConsultationLoading extends CommonConsultationState {}

final class CommonConsultationSuccess extends CommonConsultationState {
  final String successmsg;

  CommonConsultationSuccess({required this.successmsg});
}

final class CommonConsultationLoadedSuccessfully extends CommonConsultationState {
  final CommonConsultationModel consultationModel;

  CommonConsultationLoadedSuccessfully({required this.consultationModel});
}

final class CommonConsultationFail extends CommonConsultationState {
  final String errmsg;

  CommonConsultationFail({required this.errmsg});
}

final class CommonConsultationListLoaded extends CommonConsultationState {
  final List<CommonConsultationModel> commonConsultationList;

  CommonConsultationListLoaded({required this.commonConsultationList});
}

final class CommonConsultationIdLoaded extends CommonConsultationState {
  final CommonConsultationModel consultationModel;

  CommonConsultationIdLoaded({required this.consultationModel});
}
