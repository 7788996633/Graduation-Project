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
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailsScreen(userModel: userModel),
            ),
          );
        },
        title: Text("User ID: ${userModel.id}"),
        subtitle: Text("Name: ${userModel.name}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                        create: (_) => EmployeeBloc(),
                        child:  AddEmployeeScreen(userId: userModel.id),
                  ),
                ));
              },
              icon: const Icon(Icons.person_add_alt_1, color: AppColors.darkBlue),
              tooltip: 'Add Employee',
            ),

            IconButton(
              onPressed: () {
                BlocProvider.of<UserBloc>(context).add(
                  DeleteUserById(userId: userModel.id),
                );
              },
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Delete User',
            ),
          ],
        ),
      ),
    );
  }
}
