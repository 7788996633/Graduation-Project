import 'package:bloc/bloc.dart';
import 'package:graduation/data/repositories/session_points_repository.dart';
import 'package:graduation/data/services/session_points_services.dart';
import 'package:graduation/data/session_points_model.dart';
import 'package:meta/meta.dart';

part 'session_points_event.dart';
part 'session_points_state.dart';

class SessionPointsBloc extends Bloc<SessionPointsEvent, SessionPointsState> {
  SessionPointsBloc() : super(SessionPointsInitial()) {
    on<SessionPointsEvent>(
      (event, emit) async {
        if (event is GetAllPointByIssueId) {
          emit(
            SessionPointsLoading(),
          );
          try {
            List<SessionPointsModel> points =
                await SessionPointsRepository().getAllPointsByIssueId(
              event.issueId,
            );
            emit(
              SessionPointsListLoaded(
                points: points,
              ),
            );
          } catch (e) {
            emit(
              SessionPointsFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is EvaluateLawyerPoints) {
          emit(
            SessionPointsLoading(),
          );
          try {
          String message =
                await SessionPointsServices().evaluateLawyerPoints(
              event.sessionId,event.lawyerId,event.points,event.notes
            );
            emit(
              SessionPointsSuccess(
                successmsg: message,
              ),
            );
          } catch (e) {
            emit(
              SessionPointsFail(
                errmsg: e.toString(),
              ),
            );
          }
        }
      },
    );
  }
}
