import '../models/session_type_model.dart';
import '../services/session_type_service.dart';

class SessionTypeRepository {
  Future<List<SessionTypeModel>> getSessionTypes() async {
    var sessionTypesList = await SessionTypeServices().getSessionTypes();
    return sessionTypesList
        .map(
          (e) => SessionTypeModel.fromJson(e),
    )
        .toList();
  }
}
