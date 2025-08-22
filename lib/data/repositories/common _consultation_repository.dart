import '../models/common _consultation_model.dart';

import '../services/common _consultation_services.dart';


class CommonConsultationRepository {
  Future<List<CommonConsultationModel>> getCommonConsultations() async {
    var consultationsList = await CommonConsultationServices().getCommonConsultations();
    return consultationsList
        .map(
          (e) => CommonConsultationModel.fromJson(e),
    )
        .toList();
  }
}
