import 'package:meta/meta.dart';

@immutable
sealed class ArchiveEvent {}

class AddArchiveEvent extends ArchiveEvent {
  final int issueId;

  AddArchiveEvent({
    required this.issueId,
  });
}


class AddUnArchiveIssue extends ArchiveEvent {
  final int issueId;
  AddUnArchiveIssue({
    required this.issueId,
  });
}


class GetArchiveByIdEvent extends ArchiveEvent {
  final int archiveId;

  GetArchiveByIdEvent({required this.archiveId});
}

class GetAllArchivedIssuesEvent extends ArchiveEvent {}
class GetMyArchivedIssuesEvent extends ArchiveEvent {}

class UpdateArchiveEvent extends ArchiveEvent {
  final int archiveId;
  final int points;

  UpdateArchiveEvent({
    required this.archiveId,
    required this.points,
  });
}

class DeleteArchiveEvent extends ArchiveEvent {
  final int archiveId;

  DeleteArchiveEvent({
    required this.archiveId,
  });
}
