import '../models/hiring_request_model.dart';
import '../services/hiring_requests_services.dart';

class HiringRequestRepository {
  Future<List<HiringRequestModel>> getHiringRequests() async {
    var hiringRequestsList = await HiringRequestsServices ().getHiringRequests();
    return  hiringRequestsList
        .map(
          (e) => HiringRequestModel.fromJson(e),)
        .toList();
  }

}
