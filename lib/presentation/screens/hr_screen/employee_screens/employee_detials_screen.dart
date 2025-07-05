import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/employee_bloc/employee_bloc.dart';
import '../../../../blocs/job_application/job_application_bloc.dart';

import '../../../../data/models/employee_model.dart';
import '../../../../themes.dart';

import '../../../widgets/custom_appbar_add.dart';
import '../job_application/add_job_application.dart';
import 'update_employee_screen.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final EmployeeModel employeeModel;

  const EmployeeDetailsScreen({super.key, required this.employeeModel});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late EmployeeModel employee;

  @override
  void initState() {
    super.initState();
    employee = widget.employeeModel;
  }

  void refreshData(EmployeeModel updated) {
    setState(() {
      employee = updated;
    });
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: valueColor ?? Colors.black87,
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
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: CustomActionAppBar(
        title: 'Employee Details',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 12,
          shadowColor: Colors.deepPurple.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.assignment_ind_outlined,
                    size: 80,
                    color: AppColors.darkBlue,
                    shadows: [
                      Shadow(
                        color: Colors.blueAccent.shade200.withOpacity(0.6),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildInfoRow('ID', employee.id.toString()),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('name', employee.name),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Type', employee.type),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('email', employee.email),

                const SizedBox(height: 30),

                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: const Text("Apply for Job"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => JobApplicationBloc(),
                            child: AddJobApplicationScreen(
                              hiringReqId: employee.id,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push<EmployeeModel>(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => EmployeeBloc(),
                child:  UpdateEmployeeInfoScreen(employee: employee),
              ),
            ),
          );

          if (result != null) {
            refreshData(result);
          }
        },
        icon: const Icon(Icons.edit),
        label: const Text(
          'Edit',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.darkBlue,
        elevation: 6,
        hoverElevation: 12,
        extendedPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
