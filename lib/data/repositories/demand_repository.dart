
import '../models/demand_model.dart';
import '../services/demand_services.dart';

class DemandRepository {
  Future<List<DemandModel>> getAllDemands(int idIssue) async {
    var demandList = await DemandServices().getAllDemandByIssueId(idIssue);
    return demandList
        .map(
          (e) => DemandModel.fromJson(e),
        )
        .toList();
  }
}
