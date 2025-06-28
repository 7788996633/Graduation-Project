import 'dart:io';
import 'package:meta/meta.dart';

@immutable
sealed class DocumentEvent {}

class AddDocumentEvent extends DocumentEvent {
  final dynamic file;
  final String privacy;
  final int sessionId;
  final String fileName;

  AddDocumentEvent({
    required this.file,
    required this.privacy,
    required this.sessionId,
    required this.fileName,
  });
}

class GetAllDocumentsEvent extends DocumentEvent {}

class ShowDocumentByIdEvent extends DocumentEvent {
  final int documentId;
  final int sessionId;

  ShowDocumentByIdEvent({
    required this.documentId,
    required this.sessionId,
  });
}

class UpdateDocumentEvent extends DocumentEvent {
  final int documentId;
  final String? privacy;
  final String? fileName;
  final dynamic file; // اختياري: لتعديل الملف أيضاً

  UpdateDocumentEvent({
    required this.documentId,
    this.privacy,
    this.fileName,
    this.file,
  });
}

class DeleteDocumentEvent extends DocumentEvent {
  final int documentId;

  DeleteDocumentEvent({
    required this.documentId,
  });
}
