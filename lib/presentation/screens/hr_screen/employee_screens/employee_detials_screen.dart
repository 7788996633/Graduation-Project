 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../blocs/employee_bloc/employee_bloc.dart';
import '../../../../blocs/employee_bloc/employee_event.dart';
import '../../../../blocs/employee_bloc/employee_state.dart';
import '../../../../data/models/employee_model.dart';
import '../../../../data/models/user_model.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';
import 'update_employee_screen.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final UserModel userModel;

  const EmployeeDetailsScreen({super.key, required this.userModel});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late UserModel userModel;
  EmployeeModel? employeeModel;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
  }

  void refreshData(EmployeeModel updated) {
    setState(() {
      employeeModel = updated;
    });
  }

  String prepareFullUrl(String value) {
    const String baseUrl = 'http://127.0.0.1/LawCompany/public/';
    return value.startsWith('http') ? value : '$baseUrl$value';
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(prepareFullUrl(url));
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('❌ لا يمكن فتح الرابط'),
          backgroundColor: AppColors.darkBlue,
        ),
      );
    }
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool isLink = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.darkBlue, size: 22),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: isLink
                ? GestureDetector(
                    onTap: () {
                      if (value.isNotEmpty) {
                        _openUrl(value);
                      }
                    },
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        height: 1.3,
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.darkBlue,
                      height: 1.3,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeBloc()
        ..add(
          GetEmployeeByIdEvent(
            employeeId: userModel.id,
          ),
        ),
      child: Scaffold(
        backgroundColor: AppColors.scaffold,
        appBar: const CustomActionAppBar(title: 'Employee Details'),
        body: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmployeeLoadedSuccessfully) {
              employeeModel = state.employeeModel;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 8,
                  color: Colors.white,
                  shadowColor: Colors.blueGrey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Icon(
                            Icons.assignment_ind_rounded,
                            size: 72,
                            color: AppColors.darkBlue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildInfoRow(
                            icon: Icons.person,
                            label: 'Name',
                            value: userModel.name),
                        _buildInfoRow(
                            icon: Icons.email,
                            label: 'Email',
                            value: userModel.email),
                        _buildInfoRow(
                            icon: Icons.work,
                            label: 'Role',
                            value: userModel.roleName),
                        _buildInfoRow(
                          icon: Icons.attach_money,
                          label: 'Salary',
                          value: employeeModel!.salary.toString(),
                        ),
                        _buildInfoRow(
                          icon: Icons.file_present,
                          label: 'Certificate',
                          value: employeeModel!.certificate.isNotEmpty
                              ? employeeModel!.certificate
                              : 'No certificate uploaded',
                          isLink: employeeModel!.certificate.isNotEmpty,
                        ),
                        _buildInfoRow(
                          icon: Icons.date_range_outlined,
                          label: 'Hire Date',
                          value: _formatDate(employeeModel!.hireDate),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is EmployeeFail) {
              return Center(
                child: Text(
                  'Error: ${state.errMsg}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(child: Text('Something went wrong...'));
            }
          },
        ),
        floatingActionButton: employeeModel == null
            ? null
            : FloatingActionButton.extended(
                onPressed: () async {
                  final result = await Navigator.push<EmployeeModel>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => EmployeeBloc(),
                        child:
                            UpdateEmployeeInfoScreen(employee: employeeModel!),
                      ),
                    ),
                  );
                  if (result != null) {
                    refreshData(result);
                  }
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  'Edit',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                backgroundColor: AppColors.darkBlue,
              ),
      ),
    );
  }
}
