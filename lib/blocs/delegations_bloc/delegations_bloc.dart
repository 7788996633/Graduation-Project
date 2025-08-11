import 'dart:core';
import 'package:bloc/bloc.dart';

import '../../data/models/delegations_model.dart';
import '../../data/repositories/delegations_repository.dart';
import '../../data/services/delegations_service.dart';

import 'delegations_event.dart';
import 'delegations_state.dart';

class DelegationBloc extends Bloc<DelegationEvent, DelegationState> {
  DelegationBloc() : super(DelegationInitial()) {
    List<DelegationModel> allDelegations = [];

    on<DelegationEvent>((event, emit) async {
      if (event is AddDelegationEvent) {
        emit(DelegationLoading());
        try {
          String result = await DelegationServices().addSubmitDelegation(
            file: event.file,
            delegationFileName: event.delegationFileName,
            sessionId: event.sessionId,
            originalLawyerId: event.originalLawyerId,
          );
          emit(DelegationSuccess(successMsg: result));
        } catch (e) {
          emit(DelegationFail(errMsg: e.toString()));
        }
      } else if (event is AddApproveDelegationEvent) {
        emit(DelegationLoading());
        try {
          String result = await DelegationServices().addApproveDelegation(
            sessionId: event.sessionId,
            originalLawyerId: event.originalLawyerId,
            delegateLawyerId: event.delegateLawyerId,
            adminNote: event.adminNote,
          );
          emit(DelegationSuccess(successMsg: result));
        } catch (e) {
          emit(DelegationFail(errMsg: e.toString()));
        }
      } else if (event is AddRejectDelegationEvent) {
        emit(DelegationLoading());
        try {
          String result = await DelegationServices().addRejectDelegation(
            sessionId: event.sessionId,
            originalLawyerId: event.originalLawyerId,
            delegateLawyerId: event.delegateLawyerId,
            adminNote: event.adminNote,
          );
          emit(DelegationSuccess(successMsg: result));
        } catch (e) {
          emit(DelegationFail(errMsg: e.toString()));
        }
      } else if (event is GetAllDelegationsEvent) {
        emit(DelegationLoading());
        try {
          allDelegations = await DelegationRepository().getDelegations();
          emit(DelegationListLoaded(list: allDelegations));
        } catch (e) {
          emit(DelegationFail(errMsg: e.toString()));
        }
      } else if (event is UpdateDelegationEvent) {
        emit(DelegationLoading());
        try {
          String result = await DelegationServices().updateDelegation(
            delegationId: event.delegationId,
            delegationFile: event.delegationFile,
            delegationFileName: event.delegationFileName,
          );
          emit(DelegationSuccess(successMsg: result));
        } catch (e) {
          emit(DelegationFail(errMsg: e.toString()));
        }
      } else if (event is DeleteDelegationEvent) {
        emit(DelegationLoading());
        try {
          String result =
          await DelegationServices().deleteDelegation(event.delegationId);
          emit(DelegationSuccess(successMsg: result));
        } catch (e) {
          emit(DelegationFail(errMsg: e.toString()));
        }
      } else if (event is GetDelegationByIdEvent) {
        emit(DelegationLoading());
        try {
          DelegationModel delegation = await DelegationServices()
              .getDelegationById(event.delegationId);
          emit(DelegationLoaded(delegation: delegation));
        } catch (e) {
          emit(DelegationFail(errMsg: e.toString()));
        }
      }
    });
  }
}
