import 'package:meta/meta.dart';

@immutable
sealed class RequiredDocumentsEvent {}

class CreateRequiredDocumentsEvent extends RequiredDocumentsEvent {
  final int issueId;
  final String requireFileType;
  final String note;

  CreateRequiredDocumentsEvent({required this.issueId,required this.requireFileType, required this.note,});
}

class ShowRequiredDocumentsEvent extends RequiredDocumentsEvent {}

class GetAllRequiredDocuments extends RequiredDocumentsEvent {}

class GetRequiredDocumentsById extends RequiredDocumentsEvent {
  final int requiredDocumentId;

  GetRequiredDocumentsById({required this.requiredDocumentId});
}

class GetMyRequiredDocUp extends RequiredDocumentsEvent {
  final int issueId;

  GetMyRequiredDocUp({required this.issueId});
}
class UpdateRequiredDocumentsEvent extends RequiredDocumentsEvent {
  final int requiredDocumentId;
  final String status;
  final String note;
  UpdateRequiredDocumentsEvent({
    required this.requiredDocumentId,
    required this.status,
    required this.note,
  });
}

class DeleteRequiredDocumentsEvent extends RequiredDocumentsEvent {
  final int requiredDocumentId;

  DeleteRequiredDocumentsEvent({
    required this.requiredDocumentId,
  });}
class UploadRequiredDocumentEvent extends RequiredDocumentsEvent {
  final int issueId;
  final String filePath;

  UploadRequiredDocumentEvent({
    required this.issueId,
    required this.filePath,
  });
}
