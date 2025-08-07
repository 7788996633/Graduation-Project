import '../models/archive_model.dart';

import '../services/archive_services.dart';

class ArchiveRepository {
  Future<List<ArchiveModel>> getAllMyArchives() async {
    var archivesList = await ArchiveServices().getMyArchivedIssues();
    return archivesList
        .map(
          (e) => ArchiveModel.fromJson(e),
    )
        .toList();
  }


  Future<List<ArchiveModel>> getAllIssuesArchived() async {
    var archivesList = await ArchiveServices().getAllIssuesArchived();
    return archivesList
        .map(
          (e) => ArchiveModel.fromJson(e),
    )
        .toList();
  }


}
