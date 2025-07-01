import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import '../../data/models/user_model.dart';

import '../../data/repositories/users_repositories.dart';
import '../../data/services/users_services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>(
      (event, emit) async {
        //  if (event is GetUserById) {
        //   emit(
        //     UserLoading(),
        //   );
        //   try {
        //     UserModel value = await UserServices().getUserById(event.userId);
        //     if (value.id != -1) {
        //       emit(
        //         UserInfoByIdLoaded(
        //           userModel: value,
        //         ),
        //       );
        //     } else {
        //       emit(
        //         UserFail(
        //           errmsg: 'Something went wrong',
        //         ),
        //       );
        //     }
        //   } catch (e) {
        //     emit(
        //       UserFail(
        //         errmsg: e.toString(),
        //       ),
        //     );
        //   }
        // }
        if (event is GetAllClients) {
          emit(
            UserLoading(),
          );
          try {
            List<UserModel> value = await UsersRepositories().getAllUsers();
            List<UserModel> clientList = value
                .where(
                  (element) => element.roleName.toLowerCase() == 'user',
                )
                .toList();
            emit(
              UsersListLoaded(
                usersList: clientList,
              ),
            );
          } catch (e) {
            emit(
              UserFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetAllUsers) {
          emit(
            UserLoading(),
          );
          try {
            List<UserModel> value = await UsersRepositories().getAllUsers();
            emit(
              UsersListLoaded(
                usersList: value,
              ),
            );
          } catch (e) {
            emit(
              UserFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is ChangeUserRole) {
          try {
            String value =
                await UsersServices().changeUserRole(event.userId, event.role);
            emit(
              UserSuccess(
                successmsg: value,
              ),
            );
          } catch (e) {
            emit(
              UserFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is DeleteUserById) {
          try {
            String value = await UsersServices().deleteUserById(event.userId);
            emit(
              UserSuccess(
                successmsg: value,
              ),
            );
          } catch (e) {
            emit(
              UserFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetUserRole) {
          emit(
            UserLoading(),
          );
          try {
            String role = await UsersServices().getMyRole();
            emit(
              UserSuccess(
                successmsg: role.toLowerCase(),
              ),
            );
          } catch (e) {
            emit(
              UserFail(
                errmsg: e.toString(),
              ),
            );
          }
        }
      },
    );
  }
}
