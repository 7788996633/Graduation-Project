import 'package:graduation/blocs/issue_bloc/issues_bloc.dart';

import '../../../data/models/issues_model.dart';
import '../services/issus_services.dart';

class IssuesRepository {
  Future<List<IssuesModel>> getAllIssues() async {
    var issueList = await IssusServices().issueShowAllServices();
    return issueList
        .map(
          (e) => IssuesModel.fromJson(e),
        )
        .toList();
  }
Future<List<IssuesModel>> getIssuesByCategoryId(int catId) async {
    var issueList = await IssusServices().getIssuesByCategory(catId);
    return issueList
        .map(
          (e) => IssuesModel.fromJson(e),
        )
        .toList();
  }
  Future<List<IssuesModel>> getAllLawyerIssues() async {
    var issueList = await IssusServices().showAllLawyerIssues();
    return issueList
        .map(
          (e) => IssuesModel.fromJson(e),
        )
        .toList();
  }

  Future<List<IssuesModel>> getAllClientissues() async {
    var issueList = await IssusServices().showAllClientIssues();
    return issueList
        .map(
          (e) => IssuesModel.fromJson(e),
        )
        .toList();
  }
}
