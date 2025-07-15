import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/employee_bloc/employee_bloc.dart';
import '../../blocs/employee_bloc/employee_event.dart';
import '../../blocs/user_bloc/user_bloc.dart';

import '../../data/models/employee_model.dart';
import '../../themes.dart';
import '../screens/hr_screen/employee_screens/employee_detials_screen.dart';


class EmployeeItem extends StatelessWidget {
  const EmployeeItem({super.key, required this.employeeModel});
  final EmployeeModel employeeModel;

  @override
  Widget build(BuildContext context) {
    // Validate userId before proceeding
    if (employeeModel.userId <= 0) {
      return _buildErrorCard('Invalid user ID');
    }

    return BlocProvider(
      create: (_) => UserBloc()..add(GetUserById(userId: employeeModel.userId)),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue,
                ),
              ),
              subtitle: _buildSubtitle(state),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSubtitle(UserState state) {
    if (state is UserLoading) {
      return const Padding(
        padding: EdgeInsets.only(top: 4),
        child: Text(
          'Loading user data...',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textGrey,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    } else if (state is UserFail) {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          'Error: ${state.errmsg}',
          style: const TextStyle(
            color: Colors.redAccent,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else if (state is UserLoadedSuccessfully) {
      final user = state.userModel;
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              icon: Icons.person,
              label: 'Name: ',
              value: user.name,
            ),
            _buildInfoRow(
              icon: Icons.email,
              label: 'Email: ',
              value: user.email,
            ),
            _buildInfoRow(
              icon: Icons.work,
              label: 'Role: ',
              value: user.roleName,
            ),
            _buildInfoRow(
              icon: Icons.attach_money,
              label: 'Salary: ',
              value: '\$${employeeModel.salary}',
            ),
          ],
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.only(top: 4),
        child: Text(
          'User data not loaded',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textGrey,
          ),
        ),
      );
    }
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.darkBlue),
          const SizedBox(width: 6),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14),
              children: [
                TextSpan(
                  text: label,
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCard(String message) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        title: Text(
          "Employee #${employeeModel.id}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBlue,
          ),
        ),
        subtitle: Text(
          message,
          style: const TextStyle(
            color: Colors.redAccent,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}