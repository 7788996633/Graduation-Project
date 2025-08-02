part of 'archive_bloc.dart';

@immutable
sealed class ArchiveState {}

final class ArchiveInitial extends ArchiveState {}

final class ArchiveLoading extends ArchiveState {}

final class ArchiveSuccess extends ArchiveState {
  final String successMsg;

  ArchiveSuccess({required this.successMsg});
}

final class ArchiveLoaded extends ArchiveState {
  final ArchiveModel archive;

  ArchiveLoaded({required this.archive});
}

final class ArchiveListLoaded extends ArchiveState {
  final List<ArchiveModel> list;

  ArchiveListLoaded({required this.list});
}

final class ArchiveFail extends ArchiveState {
  final String errMsg;

  ArchiveFail({required this.errMsg});
}
