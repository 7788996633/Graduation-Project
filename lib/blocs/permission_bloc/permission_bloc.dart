import 'package:bloc/bloc.dart';
import 'package:graduation/data/models/permission_model.dart';
import 'package:graduation/data/repositories/permission_repository.dart';
import 'package:graduation/data/services/permission_services.dart';
import 'package:meta/meta.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial()) {
    on<PermissionEvent>((event, emit) async {
      if (event is AddPermissionEvent) {
        emit(
          PermissionLoading(),
        );
        try {
         String value =
              await PermissionServices().addPermission(event.name, event.RoleId);
          emit(
            PermissionAddedSuccessfully(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            PermissionFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is GetAllPermissionEvent) {

          emit(
            PermissionLoading(),
          );
          try {
            List<PermissionModel> value =
            await PermissionRepository().getAllPermissions();
            emit(
              getAllPermissionsSuccessfully(
                permissions: value,
              ),
            );
          } catch (e) {
            emit(
              PermissionFail(
                errmsg: e.toString(),
              ),
            );
          }}
      else if (event is AssignPermissions) {

        emit(
          PermissionLoading(),
        );
        try {
          String value =
          await PermissionServices().assignPermissions(event.RoleId, event.PermissionsId);
          emit(
            AssignPermissionSuccessfully(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            PermissionFail(
              errmsg: e.toString(),
            ),
          );
        }}
      else if (event is AssignPermissions) {

        emit(
          PermissionLoading(),
        );
        try {
          String value =
          await PermissionServices().assignPermissions(event.RoleId, event.PermissionsId);
          emit(
            AssignPermissionSuccessfully(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            PermissionFail(
              errmsg: e.toString(),
            ),
          );
        }}
      else if (event is AddNewRoleEvent) {

        emit(
          RoleLoading(),
        );
        try {
          String value =
          await PermissionServices().addNewRole(event.name);
          emit(
            RoleAddedSuccessfully(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            RoleFail(
              errmsg: e.toString(),
            ),
          );
        }}
      else if (event is GetAllPermissionByRoleIdEvent) {

        emit(
          PermissionLoading(),
        );
        try {
          List<PermissionModel> value=
          await PermissionRepository().getAllPermissionsByRoleId(event.RoleId);
          emit(
            getAllPermissionsByRoleIdSuccessfully(
              permissions:  value,
            ),
          );
        } catch (e) {
          emit(
           PermissionFail(errmsg: e.toString())
          );
        }}
    });
  }
}
