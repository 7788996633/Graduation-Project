import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user_bloc/user_bloc.dart';
import '../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../data/models/user_model.dart';
import 'user_item.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UserListState();
}

class _UserListState extends State<UsersList> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(
      GetAllUsers(),
    );
    super.initState();
  }

  List<UserModel> usersList = [];
  Widget buildUserModel() {
    return ListView.builder(
      itemCount: usersList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => BlocProvider(
        create: (context) => UserProfileBloc(),
        child: UserItem(
          userModel: usersList[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successmsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          BlocProvider.of<UserBloc>(context).add(
            GetAllUsers(),
          );
        } else if (state is UserFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errmsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          CircularProgressIndicator();
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UsersListLoaded) {
            usersList = state.usersList;
            return usersList.isEmpty
                ? const Text('There is no users')
                : buildUserModel();
          } else if (state is UserFail) {
            return Column(
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.errmsg,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
