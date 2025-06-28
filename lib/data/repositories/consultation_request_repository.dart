import 'package:graduation/data/services/consultation_request_services.dart';

import '../models/consultation_Request_model.dart';

class ConsultationRequestRepository {
  Future<List<ConsultationRequestModel>>getALLConsultationRequest() async {
    var consultationRequest = await  ConsultationRequestServices().getAllConsultationRequest();
    return consultationRequest
        .map(
          (e) => ConsultationRequestModel.fromJson(e),
    )
        .toList();

  }


}