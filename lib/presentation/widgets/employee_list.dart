import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user_bloc/user_bloc.dart';
import '../../data/models/user_model.dart';
import 'employee_item.dart';


class EmployeeList extends StatefulWidget {
  final Function(int)? onUserSelected;

  const EmployeeList({super.key, this.onUserSelected});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<UserModel> employeeList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetAllEmployees());
  }

  Widget buildUserList() {
    return ListView.builder(
      itemCount: employeeList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final user = employeeList[index];
        return EmployeeItem1(userModel: user);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          BlocProvider.of<UserBloc>(context).add(GetAllUsers());
        } else if (state is UserFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errmsg, style: const TextStyle(fontSize: 16)),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UsersListLoaded) {
            employeeList = state.usersList;
            return employeeList.isEmpty
                ? const Center(child: Text('There are no users'))
                : buildUserList();
          } else if (state is UserFail) {
            return Column(
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  state.errmsg,
                  style: const TextStyle(fontSize: 30),
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
