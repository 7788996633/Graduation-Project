import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/user_bloc/user_bloc.dart';
import '../../../../themes.dart';

import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/employee_list.dart';

class ListEmployeesScreen extends StatefulWidget {
  const ListEmployeesScreen({super.key});

  @override
  State<ListEmployeesScreen> createState() => _ListEmployeesScreenState();
}

class _ListEmployeesScreenState extends State<ListEmployeesScreen> {
  late UserBloc bloc;
  int? selectedUserId;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(GetAllEmployees());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: const CustomActionAppBar(
        title: 'List Employees',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            bloc.add(GetAllEmployees());
            await Future.delayed(const Duration(seconds: 1));
          },
          child: EmployeeList(
            onUserSelected: (userId) {
              setState(() {
                selectedUserId = userId;
              });
            },
          ),
        ),
      ),
    );
  }
}
