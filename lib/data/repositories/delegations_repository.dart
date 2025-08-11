
import '../models/delegations_model.dart';
import '../services/delegations_service.dart';
class DelegationRepository {
  Future<List<DelegationModel>> getDelegations() async {
    var delegationsList = await DelegationServices().getDelegations();
    return delegationsList
        .map(
          (e) => DelegationModel.fromJson(e),
    )
        .toList();
  }
}
