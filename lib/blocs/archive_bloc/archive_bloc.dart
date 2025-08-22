import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/archive_model.dart';
import '../../data/repositories/archive_repository.dart';

import '../../data/services/archive_services.dart';
import 'archive_event.dart';
part 'archive_state.dart';

class ArchiveBloc extends Bloc<ArchiveEvent, ArchiveState> {
  ArchiveBloc() : super(ArchiveInitial()) {
    List<ArchiveModel> allArchives = [];

    on<ArchiveEvent>((event, emit) async {
      if (event is AddArchiveEvent) {
        emit(ArchiveLoading());
        try {
          String result = await ArchiveServices()
              .addArchiveIssue(event.issueId);
          emit(ArchiveSuccess(successMsg: result));
        } catch (e) {
          emit(ArchiveFail(errMsg: e.toString()));
        }
      } else if (event is GetArchiveByIdEvent) {
        emit(ArchiveLoading());
        try {
          ArchiveModel archive = await ArchiveServices()
              .getArchivedIssueById(event.archiveId);
          emit(ArchiveLoaded(archive: archive));
        } catch (e) {
          emit(ArchiveFail(errMsg: e.toString()));
        }
      } else if (event is GetAllArchivedIssuesEvent) {
        emit(ArchiveLoading());
        try {
          allArchives = await ArchiveRepository().getAllIssuesArchived();
          emit(ArchiveListLoaded(list: allArchives));
        } catch (e) {
          emit(ArchiveFail(errMsg: e.toString()));
        }
      } else if (event is GetMyArchivedIssuesEvent) {
        emit(ArchiveLoading());
        try {
          allArchives = await ArchiveRepository().getAllMyArchives();
          emit(ArchiveListLoaded(list: allArchives));
        } catch (e) {
          emit(ArchiveFail(errMsg: e.toString()));
        }
      }   if (event is AddUnArchiveIssue) {
        emit(ArchiveLoading());
        try {
          String result = await ArchiveServices()
              .addUnArchiveIssue(event.issueId);
          emit(ArchiveSuccess(successMsg: result));
        } catch (e) {
          emit(ArchiveFail(errMsg: e.toString()));
        }
      }
    });
  }
}
