import '../models/furlough_request_model.dart';
import '../services/furlough_request_services.dart';


class FurloughRequestRepository {
  Future<List<FurloughRequestModel>> furloughRequests() async {
    var furloughRequestsList = await FurloughRequestsServices().getFurloughRequests();
    return furloughRequestsList
        .map(
          (e) => FurloughRequestModel.fromJson(e),
    )
        .toList();
  }
}
