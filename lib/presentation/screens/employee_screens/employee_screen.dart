import 'package:flutter/material.dart';

import 'add_employee_screen.dart';
import 'edit_employee_screen.dart';
import 'get_employee_screen.dart';
import 'delete_employee_screen.dart';
import 'employee_list_screen.dart';

class EmployeeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("إدارة الموظفين"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildButton(context, "إضافة موظف", AddEmployeeScreen()),
            _buildButton(context, "تعديل موظف", EditEmployeeScreen()),
            _buildButton(context, "عرض موظف", GetEmployeeScreen()),
            _buildButton(context, "حذف موظف", DeleteEmployeeScreen()),
            _buildButton(context, "كل الموظفين", EmployeeListScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, Widget screen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16),
        textStyle: TextStyle(fontSize: 18),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Text(title, textAlign: TextAlign.center),
    );
  }
}
