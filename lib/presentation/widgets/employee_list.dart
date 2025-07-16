import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/employee_bloc/employee_bloc.dart';
import '../../blocs/employee_bloc/employee_event.dart';
import '../../blocs/employee_bloc/employee_state.dart';
import '../../data/models/employee_model.dart';
import 'employee_item.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key, required this.bloc});
  final EmployeeBloc bloc;

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllEmployeesEvent());
  }

  List<EmployeeModel> employeeList = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllEmployeesEvent());
        } else if (state is EmployeeFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeListLoaded) {
            employeeList = state.employeeList;
            if (employeeList.isEmpty) {
              return const Center(child: Text('There are no employees.'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: employeeList.length,
                itemBuilder: (context, index) {
                  return EmployeeItem(
                    employeeModel: employeeList[index],
                  );
                },
              ),
            );
          } else if (state is EmployeeFail) {
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
                  state.errMsg,
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
