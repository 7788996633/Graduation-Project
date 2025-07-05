import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/employee_bloc/employee_bloc.dart';
import '../../blocs/employee_bloc/employee_event.dart';
import '../../data/models/employee_model.dart';

import '../screens/hr_screen/employee_screens/employee_detials_screen.dart';

class EmployeeItem extends StatelessWidget {
  const EmployeeItem({super.key, required this.employeeModel});
  final EmployeeModel employeeModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeDetailsScreen(
                employeeModel: employeeModel,
              ),
            ),
          );
        },
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<EmployeeBloc>(context).add(
              DeleteEmployeeEvent(employeeId: employeeModel.id),
            );
          },
          icon: const Icon(Icons.delete, color: Colors.red),
        ),
        title: Text(
          "Employee #${employeeModel.id}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text("name: ${employeeModel.name}"),
            Text("email: ${employeeModel.email}"),

          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
