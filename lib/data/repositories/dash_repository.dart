import '../services/dash_services.dart';
import '../models/dash_model.dart';

class DashRepository {
  final DashServices _dashServices = DashServices();

  Future<List<DashCount>> getMonthlyCosts() async {
    final response = await _dashServices.fetchMonthlyCosts();
    return (response as List).map((e) => DashCount.fromJson({
      'month': e['month'],
      'total_cost': e['total_cost'],
      'total_revenue': 0,
    })).toList();
  }

  Future<List<DashCount>> getMonthlyRevenues() async {
    final response = await _dashServices.fetchMonthlyRevenues();
    return (response as List).map((e) => DashCount.fromJson({
      'month': e['month'],
      'total_cost': 0,
      'total_revenue': e['total_revenue'],
    })).toList();
  }
}
