import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import '../../blocs/payroll_bloc/payroll_bloc.dart'; // ✅ استدعاء البلوك
import '../../data/models/user_model.dart';
import 'user_item.dart';

class UserList extends StatefulWidget {
  const UserList({super.key, required this.bloc});
  final UserBloc bloc;

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllUsers());
  }

  List<UserModel> userList = [];

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
          widget.bloc.add(GetAllUsers());
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
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UsersListLoaded) {
            userList = state.usersList;
            if (userList.isEmpty) {
              return const Center(child: Text('There are no users.'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return BlocProvider(
                    create: (_) => PayrollBloc(), // ✅ إضافة البلوك هون
                    child: UserItem(
                      userModel: userList[index],
                    ),
                  );
                },
              ),
            );
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
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
