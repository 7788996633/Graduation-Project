import 'package:bloc/bloc.dart';

import '../../data/repositories/dashboard_repository.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _repository = DashboardRepository();

  DashboardBloc() : super(DashboardInitial()) {
    on<FetchDashboardData>((event, emit) async {
      emit(DashboardLoading());
      try {
        final openCases = await _repository.getOpenIssuesCount();
        final totalClients = await _repository.getClientCount();
        final sessionsThisMonth = await _repository.getThisMonthSessionCount();
        final totalRevenue = await _repository.getTotalRevenues();

        emit(DashboardSuccess(
          openCases: openCases,
          totalClients: totalClients,
          sessionsThisMonth: sessionsThisMonth,
            totalRevenue:totalRevenue,
        ));
      } catch (e) {
        emit(DashboardFail(errMsg: e.toString()));
      }
    });
  }
}
