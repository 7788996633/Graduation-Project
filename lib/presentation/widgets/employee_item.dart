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
    return BlocProvider(
      create: (_) => UserBloc()..add(GetUserById(userId: employeeModel.userId)),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: Colors.grey.withOpacity(0.3),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Confirm Delete'),
                  content: const Text('Are you sure you want to delete this employee?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        BlocProvider.of<EmployeeBloc>(context).add(
                          DeleteEmployeeEvent(employeeId: employeeModel.id),
                        );
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 26),
            tooltip: 'Delete Employee',
          ),
          title: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoadedSuccessfully) {
                return Text(
                  state.userModel.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.darkBlue,
                  ),
                );
              } else if (state is UserLoading) {
                return const Text(
                  'Loading name...',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                );
              } else {
                return const Text(
                  'Name not available',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                );
              }
            },
          ),
          subtitle: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    'Loading user info...',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                );
              } else if (state is UserLoadedSuccessfully) {
                final user = state.userModel;
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(Icons.email_outlined, 'Email:', user.email),
                      _buildInfoRow(Icons.work_outline, 'Role:', user.roleName),

                    ],
                  ),
                );
              } else if (state is UserFail) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Error: ${state.errmsg}',
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'User info not loaded.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                );
              }
            },
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Color(0xFF627D98)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF1B263B)),
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, fontFamily: 'Segoe UI'),
              children: [
                TextSpan(
                  text: '$label ',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    color: Color(0xFF1B263B),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
