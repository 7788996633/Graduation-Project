import '../models/consultation_model.dart';
import '../services/consultation_services.dart';

class ConsultationRepositories {
  Future<List<ConsultationModel>> getAllConsultations() async {
    var consultations = await ConsultationServices().getAllConsultations();
    return consultations
        .map(
          (e) => ConsultationModel.fromJson(e),
        )
        .toList();
  }

  Future<List<ConsultationModel>> getMyConsultationsLawyer() async {
    var consultations =
        await ConsultationServices().showMyConsultationsLawyer();
    return consultations
        .map(
          (e) => ConsultationModel.fromJson(e),
        )
        .toList();
  }

  Future<List<ConsultationModel>> getConsultationsByRequestId(int reqId) async {
    var consultations =
        await ConsultationServices().showConsultationsByRequestId(reqId);
    return consultations
        .map(
          (e) => ConsultationModel.fromJson(e),
        )
        .toList();
  }
}
