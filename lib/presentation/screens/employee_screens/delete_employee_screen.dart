import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/employee_bloc/employee_bloc.dart';

class DeleteEmployeeScreen extends StatelessWidget {
  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("حذف موظف")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: idController, decoration: InputDecoration(labelText: 'ID')),
            ElevatedButton(
              onPressed: () {
                context.read<EmployeeBloc>().add(DeleteEmployeeEvent(employeeId: int.parse(idController.text)));
              },
              child: Text("حذف"),
            ),
          ],
        ),
      ),
    );
  }
}
