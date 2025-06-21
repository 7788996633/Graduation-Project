import 'dart:io';
import 'package:meta/meta.dart';

@immutable
sealed class DocumentEvent {}

class AddDocumentEvent extends DocumentEvent {
  final File file;
  final String privacy;
  final int sessionId;

  AddDocumentEvent({
    required this.file,
    required this.privacy,
    required this.sessionId,
  });
}

class ShowDocumentByIdEvent extends DocumentEvent {
  final int documentId;
  final int sessionId;

  ShowDocumentByIdEvent({
    required this.documentId,
    required this.sessionId,
  });
}
