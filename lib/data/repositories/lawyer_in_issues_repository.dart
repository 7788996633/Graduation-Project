
import '../models/lawyer_model.dart';
import '../services/lawyer_in_issues_services.dart';

class LawyerInIssuesRepository {
  Future<List<LawyerModel>> getAllLawyerInIssuesServices(int issueId) async {
    var issueList = await LawyerInIssuesServices().getLawyerInIssuesServices( issueId);
    return issueList
        .map(
          (e) => LawyerModel.fromJson(e),
        )
        .toList();
  }
}
