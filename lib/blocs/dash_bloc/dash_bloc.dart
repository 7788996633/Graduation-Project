import 'package:bloc/bloc.dart';
import '../../data/repositories/dash_repository.dart';
import '../../data/models/dash_model.dart';
import 'dash_event.dart';
import 'dash_state.dart';

class DashBloc extends Bloc<DashEvent, DashState> {
  final DashRepository _repository = DashRepository();

  DashBloc() : super(DashInitial()) {
    on<FetchDashData>((event, emit) async {
      emit(DashLoading());
      try {
        final monthlyCosts = await _repository.getMonthlyCosts();
        final monthlyRevenues = await _repository.getMonthlyRevenues();

        // دمج البيانات حسب كل شهر
        List<DashCount> combined = [];
        for (int i = 0; i < monthlyRevenues.length; i++) {
          combined.add(DashCount(
            month: monthlyRevenues[i].month,
            totalRevenue: monthlyRevenues[i].totalRevenue,
            totalCost: i < monthlyCosts.length ? monthlyCosts[i].totalCost : 0,
          ));
        }

        emit(DashSuccess(monthlyData: combined));
      } catch (e) {
        emit(DashFail(errMsg: e.toString()));
      }
    });
  }
}
