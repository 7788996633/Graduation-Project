import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/employee_bloc/employee_bloc.dart';
import '../../../../blocs/employee_bloc/employee_event.dart';
import '../../../../constant.dart';
import '../../../../themes.dart';


import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/employee_list.dart';
import '../../../widgets/refresh_button.dart';

import 'add_employee_screen.dart';

class ListEmployeesScreen extends StatefulWidget {
  const ListEmployeesScreen({super.key});

  @override
  State<ListEmployeesScreen> createState() => _ListEmployeesScreenState();
}

class _ListEmployeesScreenState extends State<ListEmployeesScreen> {
  late EmployeeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<EmployeeBloc>(context);
    bloc.add(GetAllEmployeesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List Employees',
      ),


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            EmployeeList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllEmployeesEvent());
        },
      ),
    );
  }
}
