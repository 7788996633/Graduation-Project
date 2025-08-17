import 'package:bloc/bloc.dart';
import '../../data/models/session_model.dart';
import '../../data/repositories/sessions_repository.dart';
import '../../data/services/sessions_services.dart';
import 'sessions_event.dart';
import 'sessions_state.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  SessionsBloc() : super(SessionsInitial()) {
    on<SessionsEvent>(
      (event, emit) async {
        if (event is CreateSessionsEvent) {
          emit(
            SessionsLoading(),
          );
          try {
            String result = await SessionServices().createSession(
              event.sessionTypeId,
              event.lawyerId,
              event.issueId,
            );
            emit(
              SessionsSuccess(
                successmsg: result,
              ),
            );
          } catch (e) {
            emit(
              SessionsFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetAllSessionsEvent) {
          emit(
            SessionsLoading(),
          );
          try {
            List<SessionModel> sessionsList =
                await SessionsRepository().getSessions();
            emit(
              SessionsListLoaded(
                sessionsList: sessionsList,
              ),
            );
          } catch (e) {
            emit(
              SessionsFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetSessionsByIsssueIdEvent) {
          emit(
            SessionsLoading(),
          );
          try {
            List<SessionModel> sessionsList =
                await SessionsRepository().getSessionsBuIssueId(
              event.issueId,
            );
            emit(
              SessionsListLoaded(
                sessionsList: sessionsList,
              ),
            );
          } catch (e) {
            emit(
              SessionsFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetLawyerSessionsEvent) {
          emit(
            SessionsLoading(),
          );
          try {
            List<SessionModel> sessionsList =
                await SessionsRepository().getLawyerSessions();
            emit(
              SessionsListLoaded(
                sessionsList: sessionsList,
              ),
            );
          } catch (e) {
            emit(
              SessionsFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetClientSessionsEvent) {
          emit(
            SessionsLoading(),
          );
          try {
            List<SessionModel> sessionsList =
                await SessionsRepository().getClientSessions();
            emit(
              SessionsListLoaded(
                sessionsList: sessionsList,
              ),
            );
          } catch (e) {
            emit(
              SessionsFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetSessionsByIdEvent) {
          emit(
            SessionsLoading(),
          );
          try {
            SessionModel session = await SessionServices().getSessionById(
              event.sessionId,
            );
            emit(
              SessionLoadedSuccessfully(
                session: session,
              ),
            );
          } catch (e) {
            emit(
              SessionsFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is DeleteSessionEvent) {
          emit(
            SessionsLoading(),
          );
          try {
            String result = await SessionServices().deleteSession(
              event.sessionId,
            );
            emit(
              SessionsSuccess(
                successmsg: result,
              ),
            );
          } catch (e) {
            emit(
              SessionsFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is UpdateSessionEvent) {
          emit(
            SessionsLoading(),
          );
          try {
            String result = await SessionServices().updateSession(
              event.outcome,
              event.isAttend,
              event.sessionId,
            );
            emit(
              SessionsSuccess(
                successmsg: result,
              ),
            );
          } catch (e) {
            emit(
              SessionsFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is MarkSessionAsAttendanceEvent) {                                                  print('attendance');

          emit(
            SessionsLoading(),
          );
          try {
            String result = await SessionServices().markSessionAsAttendance(
              event.sessionId,
            );
            emit(
              SessionsSuccess(
                successmsg: result,
              ),
            );
          } catch (e) {
            emit(
              SessionsFail(
                errmsg: e.toString(),
              ),
            );
          }
        }
      },
    );
  }
}
