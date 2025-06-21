import '../../../data/services/lawyer_services.dart';

import '../models/lawyer_model.dart';

class LawyerRepository {
  // Future<String?> _getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }

  Future<List<LawyerModel>> getAllLawyers() async {
    var lawyersList = await LawyerServices().getAllLawyers();
    return lawyersList
        .map(
          (e) => LawyerModel.fromJson(e),
        )
        .toList();
  }
}
