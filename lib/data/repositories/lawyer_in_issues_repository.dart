import 'package:graduation/data/models/lawyer_in_issues.dart';
import 'package:graduation/data/services/lawyer_in_issues_services.dart';

class LawyerInIssuesRepository {
  Future<List<LawyerInIssues>> getAllLawyerInIssuesServices() async {
    var issueList = await LawyerInIssuesServices().getLawyerInIssuesServices();
    return issueList
        .map(
          (e) => LawyerInIssues.fromJson(e),
        )
        .toList();
  }
}
