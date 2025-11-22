import 'package:meta/meta.dart';

@immutable
sealed class DelegationEvent {}

class AddDelegationEvent extends DelegationEvent {
  final dynamic file; // ملف يمكن أن يكون Uint8List (لويب) أو File (موبايل)
  final int sessionId;
  final int originalLawyerId;

  AddDelegationEvent({
    required this.file,
    required this.sessionId,
    required this.originalLawyerId,
  });
}

class AddApproveDelegationEvent extends DelegationEvent {
  final int delegationId;
  final int delegateLawyerId;
  final String adminNote;

  AddApproveDelegationEvent({
    required this.delegationId,
    required this.delegateLawyerId,
    required this.adminNote,
  });
}

class AddRejectDelegationEvent extends DelegationEvent {
  final int delegationId;
  final int sessionId;
  final int originalLawyerId;
  final String adminNote;

  AddRejectDelegationEvent({
    required this.delegationId,
    required this.sessionId,
    required this.originalLawyerId,
    required this.adminNote,
  });
}

class UpdateDelegationEvent extends DelegationEvent {
  final int delegationId;
  final dynamic delegationFile; // ملف أو بيانات بايت
  final String delegationFileName;

  UpdateDelegationEvent({
    required this.delegationId,
    required this.delegationFile,
    required this.delegationFileName,
  });
}

class GetDelegationByIdEvent extends DelegationEvent {
  final int delegationId;

  GetDelegationByIdEvent({required this.delegationId});
}

class GetAllDelegationsEvent extends DelegationEvent {}

class GetAllDelegationsBySessionEvent extends DelegationEvent {
  final int sessionId;

  GetAllDelegationsBySessionEvent({required this.sessionId});
}

class SearchDelegationsByTypeEvent extends DelegationEvent {
  final String type;

  SearchDelegationsByTypeEvent({required this.type});
}

class DeleteDelegationEvent extends DelegationEvent {
  final int delegationId;

  DeleteDelegationEvent({required this.delegationId});
}
