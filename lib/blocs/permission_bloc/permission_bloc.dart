import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/permission_model.dart';
import '../../data/repositories/permission_repository.dart';

import '../../data/services/permission_services.dart';
import 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial()) {
    on<PermissionEvent>((event, emit) async {
      if (event is AddPermissionEvent) {
        emit(PermissionLoading());
        try {
          String result = await PermissionServices()
              .addPermission(event.name);
          emit(PermissionSuccess(successMsg: result));
        } catch (e) {
          emit(PermissionFail(errMsg: e.toString()));
        }
      } else if (event is GetPermissionByIdEvent) {
        emit(PermissionLoading());
        try {
          var permission = await PermissionServices()
              .getPermissionById(event.permissionId);

          emit(PermissionLoaded(permission: permission));
        } catch (e) {
          emit(PermissionFail(errMsg: e.toString()));
        }
      }
      else if (event is GetAllPermissionsEvent) {
        emit(PermissionLoading());
        try {
          List<PermissionModel> data = await PermissionRepository().getPermissions();
          emit(PermissionListLoaded(list: data));
        } catch (e) {
          emit(PermissionFail(errMsg: e.toString()));
        }
      }
      else if (event is UpdatePermissionEvent) {
        emit(PermissionLoading());
        try {
          String result = await PermissionServices()
              .updatePermission(event.permissionId, event.name );
          emit(PermissionSuccess(successMsg: result));
        } catch (e) {
          emit(PermissionFail(errMsg: e.toString()));
        }
      } else if (event is DeletePermissionEvent) {
        emit(PermissionLoading());
        try {
          String result = await PermissionServices().deletePermission(event.permissionId);
          emit(PermissionSuccess(successMsg: result));
        } catch (e) {
          emit(PermissionFail(errMsg: e.toString()));
        }
      }
    });
  }
}
