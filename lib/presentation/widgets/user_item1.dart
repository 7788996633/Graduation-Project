import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/employee_bloc/employee_bloc.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import '../../data/models/user_model.dart';
import '../../themes.dart';
import '../screens/hr_screen/employee_screens/user_detials_screen.dart';
import '../screens/hr_screen/employee_screens/add_employee_screen.dart';

class UserItem1 extends StatelessWidget {
  const UserItem1({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkBlue.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: AppColors.darkBlue.withOpacity(0.2)),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetailsScreen(userModel: userModel),
              ),
            );
          },
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.darkBlue.withOpacity(0.1),
            child: Icon(Icons.person, color: AppColors.darkBlue),
          ),
          title: Text(
            userModel.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Tooltip(
                message: 'Add Employee',
                child: IconButton(
                  icon: const Icon(Icons.person_add_alt_1),
                  color: AppColors.darkBlue,
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
              Tooltip(
                message: 'Delete User',
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context).add(
                      DeleteUserById(userId: userModel.id),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
