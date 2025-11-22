import '../services/dashboard_service.dart';
class DashboardRepository {
  final DashboardServices _dashboardServices = DashboardServices();

  Future<int> getOpenIssuesCount() async {
    return await _dashboardServices.fetchOpenIssuesCount();
  }

  Future<int> getClientCount() async {
    return await _dashboardServices.fetchClientCount();
  }

  Future<int> getThisMonthSessionCount() async {
    return await _dashboardServices.fetchThisMonthSessionCount();
  }
}
