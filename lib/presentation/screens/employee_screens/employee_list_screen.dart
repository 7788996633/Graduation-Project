import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/employee_bloc/employee_bloc.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("كل الموظفين")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<EmployeeBloc>().add(GetAllEmployeeEvent());
            },
            child: Text("تحميل الموظفين"),
          ),
          Expanded(
            child: BlocBuilder<EmployeeBloc, EmployeeState>(
              builder: (context, state) {
                if (state is EmployeeLoading)
                  return Center(child: CircularProgressIndicator());
                if (state is EmployeeListLoadedSuccessFully) {
                  return ListView.builder(
                    itemCount: state.employeeList.length,
                    itemBuilder: (context, index) {
                      final emp = state.employeeList[index];
                      return ListTile(
                        title: Text("ID: ${emp.id}"),
                        subtitle: Text("الراتب: ${emp.salary}"),
                      );
                    },
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
