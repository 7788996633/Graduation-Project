import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../screens/hr_screen/employee_screens/employee_detials_screen.dart';
import 'custom_user_item.dart';
class EmployeeItem1 extends StatelessWidget {
  const EmployeeItem1({
    super.key,
    required this.userModel,
    this.subtitle,
  });

  final UserModel userModel;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EmployeeDetailsScreen(userModel: userModel),
          ),
        );
      },
      child: CustomUserItem(
        userModel: userModel,
        subtitle: Text(
          'Role: ${userModel.roleName}',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }
}
