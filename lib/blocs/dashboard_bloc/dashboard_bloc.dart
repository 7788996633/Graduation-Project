import 'package:bloc/bloc.dart';

import '../../data/services/dashboard_service.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    final DashboardServices _services = DashboardServices();

    on<FetchDashboardData>((event, emit) async {
      emit(DashboardLoading());

      try {
        final int openCases = await _services.fetchOpenIssuesCount();
        final int totalClients = await _services.fetchClientCount();
        final int sessionsThisMonth = await _services.fetchThisMonthSessionCount();

        emit(DashboardSuccess(
          openCases: openCases,
          totalClients: totalClients,
          sessionsThisMonth: sessionsThisMonth,
        ));
      } catch (e) {
        emit(DashboardFailure(error: e.toString()));
      }
    });
  }
}
