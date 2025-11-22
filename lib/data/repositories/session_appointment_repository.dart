
import '../models/session_appointement_model.dart';
import '../services/session_appointment_services.dart';


class SessionAppointmentRepository {
  Future<List<SessionAppointementModel>> getAllSeesion(int idIssue) async {
    var demandList = await SessionAppointmentServices()
        .getAllAppointmentsBySessionId(idIssue);
    return demandList
        .map(
          (e) => SessionAppointementModel.fromJson(e),
        )
        .toList();
  }
}
