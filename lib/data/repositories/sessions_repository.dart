import '../models/session_model.dart';
import '../services/sessions_services.dart';

class SessionsRepository {
  Future<List<SessionModel>> getSessions() async {
    var sessionsList = await SessionServices().getSessions();
    return sessionsList.map((e) => SessionModel.fromJson(e)).toList();
  }

  Future<List<SessionModel>> getLawyerSessions() async {
    var sessionsList = await SessionServices().getLawyerSessions();
    return sessionsList.map((e) => SessionModel.fromJson(e)).toList();
  }

  Future<List<SessionModel>> getClientSessions() async {
    var sessionsList = await SessionServices().getClientSessions();
    return sessionsList.map((e) => SessionModel.fromJson(e)).toList();
  }
}
