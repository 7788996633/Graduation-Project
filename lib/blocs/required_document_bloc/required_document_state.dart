import 'package:meta/meta.dart';

import '../../data/models/required_document_model.dart';

@immutable
sealed class RequiredDocumentsState {}

final class RequiredDocumentsInitial extends RequiredDocumentsState {}

final class RequiredDocumentsLoading extends RequiredDocumentsState {}

final class RequiredDocumentsSuccess extends RequiredDocumentsState {
  final String successmsg;

  RequiredDocumentsSuccess({required this.successmsg});
}

final class RequiredDocumentsLoadedSuccessfully extends RequiredDocumentsState {
  final RequiredDocumentModel requiredDocumentModel;

  RequiredDocumentsLoadedSuccessfully({required this.requiredDocumentModel});
}

final class RequiredDocumentsFail extends RequiredDocumentsState {
  final String errmsg;

  RequiredDocumentsFail({required this.errmsg});
}

final class RequiredDocumentsListLoaded extends RequiredDocumentsState {
  late final List<RequiredDocumentModel> requiredDocumentsList;

  RequiredDocumentsListLoaded({required this.requiredDocumentsList});
}

final class RequiredDocumentsIdLoaded extends RequiredDocumentsState {
  final RequiredDocumentModel requiredDocumentModel;

  RequiredDocumentsIdLoaded({required this.requiredDocumentModel});
}
