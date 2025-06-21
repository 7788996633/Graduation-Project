
import 'package:meta/meta.dart';

import '../../data/models/document_model.dart';

@immutable
sealed class DocumentState {}

final class DocumentInitial extends DocumentState {}

final class DocumentLoading extends DocumentState {}

final class DocumentSuccess extends DocumentState {
  final String successmsg;

  DocumentSuccess({required this.successmsg});
}

final class DocumentFail extends DocumentState {
  final String errmsg;

  DocumentFail({required this.errmsg});
}

final class DocumentLoadedSuccessfully extends DocumentState{
  final DocumentModel document;
  DocumentLoadedSuccessfully({required this.document});
}