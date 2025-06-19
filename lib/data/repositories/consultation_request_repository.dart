import 'package:graduation/data/services/consultation_request_services.dart';

import '../models/consultation_Request_model.dart';

class ConsultationRequestRepository {
  Future<List<ConsultationRequestModel>>ge_ALLConsultationRequest() async {
    var ConsultationRequest = await  ConsultationRequestServices().getAllConsultationRequest();
    return ConsultationRequest
        .map(
          (e) => ConsultationRequestModel.fromJson(e),
    )
        .toList();

  }


}