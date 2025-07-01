import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:graduation/data/models/lawyer_in_issues.dart';
import 'package:graduation/data/repositories/lawyer_in_issues_repository.dart';

part 'lawyer_in_issues_event.dart';
part 'lawyer_in_issues_state.dart';

class LawyerInIssuesBloc
    extends Bloc<LawyerInIssuesEvent, LawyerInIssuesState> {
  LawyerInIssuesBloc() : super(LawyerInIssuesInitial()) {
    on<LawyerInIssuesEvent>((event, emit) async {
      if (event is CreateUserProfileEvent) {
        emit(
          LawyerInIssuesLoading(),
        );
        try {
          List<LawyerInIssues> value =
              await LawyerInIssuesRepository().getAllLawyerInIssuesServices();

          emit(LawyerInIssuesLoadedSuccessfully(lawyerInissues: value));
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
