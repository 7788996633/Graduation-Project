import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/employee_bloc/employee_bloc.dart';
import '../../data/models/user_model.dart';
import '../screens/hr_screen/employee_screens/add_employee_screen.dart';
import 'custom_user_item.dart';

class ClientItem1 extends StatelessWidget {
  const ClientItem1({
    super.key,
    required this.userModel,
    this.subtitle,
  });

  final UserModel userModel;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return CustomUserItem(
      userModel: userModel,
      subtitle: subtitle,
      trailing: Tooltip(
        message: 'Add Employee',
        child: IconButton(
          icon: const Icon(Icons.person_add_alt_1),
          color: Colors.blue,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => EmployeeBloc(),
                  child: AddEmployeeScreen(userId: userModel.id),
                ),
              ),
            );
          },
        ),
      ),
    );
    
  }
}
