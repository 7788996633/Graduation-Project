import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/user_bloc/user_bloc.dart';
import '../../../themes.dart';

import '../widgets/custom_appbar_add.dart';
import '../widgets/refresh_button.dart';
import '../widgets/user_list.dart';


class ListUsersScreen extends StatefulWidget {
  const ListUsersScreen({super.key});

  @override
  State<ListUsersScreen> createState() => _ListUsersScreenState();
}

class _ListUsersScreenState extends State<ListUsersScreen> {
  late UserBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(GetAllUsers()); // بدل GetAllPayrollsEvent
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Users',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UserList(bloc: bloc), // بدل PayrollList
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllUsers());
        },
      ),
    );
  }
}
