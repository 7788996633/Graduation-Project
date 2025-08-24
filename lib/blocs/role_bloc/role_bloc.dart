import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/role_model.dart';
import '../../data/repositories/role_repository.dart';
import '../../data/services/role_services.dart';
import 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc() : super(RoleInitial()) {
    on<RoleEvent>((event, emit) async {
      if (event is AddRoleEvent) {
        emit(RoleLoading());
        try {
          String result = await RoleServices().addRole(event.name);
          emit(RoleSuccess(successMsg: result));
        } catch (e) {
          emit(RoleFail(errMsg: e.toString()));
        }
      } else if (event is GetRoleByIdEvent) {
        emit(RoleLoading());
        try {
          var role = await RoleServices().getRoleById(event.roleId);
          emit(RoleLoaded(role: role));
        } catch (e) {
          emit(RoleFail(errMsg: e.toString()));
        }
      } else if (event is GetAllRolesEvent) {
        emit(RoleLoading());
        try {
          List<RoleModel> data = await RoleRepository().getRoles();
          emit(RoleListLoaded(list: data));
        } catch (e) {
          emit(RoleFail(errMsg: e.toString()));
        }
      }
    });
  }
}
