import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:untitled27/blocs/session_type_bloc/session_type_event.dart';
import '../../data/models/session_type_model.dart';
import '../../data/repositories/session_type_repository.dart';
import '../../data/services/session_type_service.dart';
part 'session_type_state.dart';
class SessionTypeBloc extends Bloc<SessionTypeEvent, SessionTypeState> {
  SessionTypeBloc() : super(SessionTypeInitial()) {
    on<SessionTypeEvent>((event, emit) async {
      if (event is AddSessionTypeEvent) {
        emit(SessionTypeLoading());
        try {
          String result = await SessionTypeServices()
              .addSessionType(event.type,event.points, event.description);
          emit(SessionTypeSuccess(successMsg: result));
        } catch (e) {
          emit(SessionTypeFail(errMsg: e.toString()));
        }
      } else if (event is GetSessionTypeByIdEvent) {
        emit(
          SessionTypeLoading(),
        );
        try {
          SessionTypeModel session = await SessionTypeServices()
              .getSessionTypeById(event.sessionTypeId);

          emit(
            SessionTypeLoaded(
              session: session,
            ),
          );
        } catch (e) {
          emit(
            SessionTypeFail(
              errMsg: e.toString(),
            ),
          );
        }
      }
      else if (event is GetAllSessionTypesEvent) {
      emit(SessionTypeLoading());
      try {
      List<SessionTypeModel> data = await SessionTypeRepository().getSessionTypes();
      emit(SessionTypeListLoaded(list: data));
      } catch (e) {
      emit(SessionTypeFail(errMsg: e.toString()));
      }
      }
      else if (event is UpdateSessionTypeEvent) {
        emit(SessionTypeLoading());
        try {
          String result = await SessionTypeServices()
              .updateSessionType(event.sessionTypeId,event.points);
          emit(SessionTypeSuccess(successMsg: result));
        } catch (e) {
          emit(SessionTypeFail(errMsg: e.toString()));
        }
      } else if (event is DeleteSessionTypeEvent) {
        emit(SessionTypeLoading());
        try {
          String result =
          await SessionTypeServices().deleteSessionType(event.sessionTypeId);
          emit(SessionTypeSuccess(successMsg: result));
        } catch (e) {
          emit(SessionTypeFail(errMsg: e.toString()));
        }
      }
    });
  }
}
