import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/services/role_services.dart';
import 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc() : super(RoleInitial()) {
    on<AddRoleEvent>((event, emit) async {
      emit(RoleLoading());
      try {
        String result = await RoleServices().addRole(event.name);
        emit(RoleSuccess(successMsg: result));
      } catch (e) {
        emit(RoleFail(errMsg: e.toString()));
      }
    });
  }
}
