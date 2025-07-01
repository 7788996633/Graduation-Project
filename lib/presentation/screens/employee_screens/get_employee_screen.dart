import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/employee_bloc/employee_bloc.dart';

class GetEmployeeScreen extends StatelessWidget {
  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("عرض موظف")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: idController,
                decoration: InputDecoration(labelText: 'ID')),
            ElevatedButton(
              onPressed: () {
                context.read<EmployeeBloc>().add(
                      GetEmployeeEvent(
                          employeeId: int.parse(idController.text)),
                    );
              },
              child: Text("جلب الموظف"),
            ),
            BlocBuilder<EmployeeBloc, EmployeeState>(
              builder: (context, state) {
                if (state is EmployeeLoading)
                  return CircularProgressIndicator();
                if (state is EmployeeLoadedSuccessFully) {
                  final emp = state.employee;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ID: ${emp.id}"),
                      Text("الراتب: ${emp.salary}"),
                    ],
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
