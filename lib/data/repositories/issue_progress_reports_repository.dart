
import '../models/issue_progress_reports_model.dart';

import '../services/issue_progress_reports_service.dart';

class IssueProgressReportRepository {
  Future<List<IssueProgressReportModel>> getIssueProgressReports() async {
    var reportList = await IssueProgressReportServices().getIssueProgressReports();
    return reportList
        .map(
          (e) => IssueProgressReportModel.fromJson(e),
    )
        .toList();
  }
}
