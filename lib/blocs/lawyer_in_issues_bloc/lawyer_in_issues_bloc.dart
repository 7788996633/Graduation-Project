import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../data/models/lawyer_model.dart';
import '../../data/repositories/lawyer_in_issues_repository.dart';

part 'lawyer_in_issues_event.dart';
part 'lawyer_in_issues_state.dart';

class LawyerInIssuesBloc
    extends Bloc<LawyerInIssuesEvent, LawyerInIssuesState> {
  LawyerInIssuesBloc() : super(LawyerInIssuesInitial()) {
    on<LawyerInIssuesEvent>((event, emit) async {
      if (event is GetAllLawyersInIssuesEvent) {
        emit(
          LawyerInIssuesLoading(),
        );
        try {
          List<LawyerModel> value = await LawyerInIssuesRepository()
              .getAllLawyerInIssuesServices(event.issueId);

          emit(LawyerInIssuesListLoadedSuccessfully(lawyerInissues: value));
        } catch (e) {
          emit(
            LawyerInIssuesFail(
              errmsg: e.toString(),
            ),
          );
        }
      }
    });
  }
}
