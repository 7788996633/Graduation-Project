import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/case_type_percentages_model.dart';
import '../../data/repositories/case_type_percentages_repository.dart';

import 'case_type_percentages_event.dart';
import 'case_type_percentages_state.dart';

class CaseTypeBloc extends Bloc<CaseTypeEvent, CaseTypeState> {
  final CaseTypeRepository _repository = CaseTypeRepository();
  CaseTypeBloc() : super(CaseTypeInitial()) {
    on<CaseTypeEvent>((event, emit) async {
      if (event is FetchCaseTypePercentages) {
        emit(CaseTypeLoading());

        try {
          List<CaseTypePercentage> data = await _repository.getCaseTypePercentages();
          emit(CaseTypeSuccess(data: data));
        } catch (e) {
          emit(CaseTypeFailure(error: e.toString()));
        }
      }
    });
  }
}