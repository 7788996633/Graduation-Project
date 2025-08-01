
import '../services/session_points_services.dart';
import '../session_points_model.dart';

class SessionPointsRepository {
  Future<List<SessionPointsModel>> getAllPointsByIssueId(int issueId) async {
    var sessionsPoints =
        await SessionPointsServices().getAllPointsByIssueId(issueId);
    return sessionsPoints
        .map(
          (e) => SessionPointsModel.fromJson(e),
        )
        .toList();
  }
}
