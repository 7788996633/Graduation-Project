import 'package:graduation/data/services/consultation_request_services.dart';

import '../models/cons_req_model.dart';

class ConsultationRequestRepository {
  Future<List<ConsReqModel>> getALLConsultationRequest() async {
    var consultationRequest =
        await ConsultationRequestServices().getAllConsultationRequest();
    return consultationRequest
        .map(
          (e) => ConsReqModel.fromJson(e),
        )
        .toList();
  }

  Future<List<ConsReqModel>> getUserConsultationRequest() async {
    var consultationRequest =
        await ConsultationRequestServices().getUserConsultationRequest();
    return consultationRequest
        .map(
          (e) => ConsReqModel.fromJson(e),
        )
        .toList();
  }
}
