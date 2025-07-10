import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/case_type_percentages_service.dart';

import 'case_type_percentages_event.dart';
import 'case_type_percentages_state.dart';


class CaseTypeBloc extends Bloc<CaseTypeEvent, CaseTypeState> {
  final CaseTypeService _service = CaseTypeService();

  CaseTypeBloc() : super(CaseTypeInitial()) {
    on<FetchCaseTypePercentages>((event, emit) async {
      emit(CaseTypeLoading());

      try {
        final data = await _service.fetchCaseTypePercentages();
        emit(CaseTypeSuccess(data: data));
      } catch (e) {
        emit(CaseTypeFailure(error: e.toString()));
      }
    });
  }
}
