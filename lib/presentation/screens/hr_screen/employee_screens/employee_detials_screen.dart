import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../blocs/employee_bloc/employee_bloc.dart';
import '../../../../data/models/employee_model.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';
import 'update_employee_screen.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final EmployeeModel employeeModel;

  const EmployeeDetailsScreen({super.key, required this.employeeModel});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late EmployeeModel employeeModel;

  @override
  void initState() {
    super.initState();
    employeeModel = widget.employeeModel;
  }

  void refreshData(EmployeeModel updated) {
    setState(() {
      employeeModel = updated;
    });
  }

  String prepareFullUrl(String value) {
    const String baseUrl = 'http://127.0.0.1/LawCompany/public/'; // عدّل حسب الباك عندك
    if (value.startsWith('http')) {
      return value;
    } else {
      return '$baseUrl$value';
    }
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(prepareFullUrl(url));
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open URL')),
      );
    }
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}";
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool isLink = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.darkBlue, size: 22),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: const TextStyle(
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
                  color: AppColors.darkBlue,
                  decoration: TextDecoration.underline,
                  height: 1.3,
                ),
              ),
            )
                : Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
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
      backgroundColor: Colors.lightBlue.shade50,
      appBar: CustomActionAppBar(title: 'Employee Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 10,
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
                  icon: Icons.badge_outlined,
                  label: 'ID',
                  value: employeeModel.id.toString(),
                ),
                _buildInfoRow(
                  icon: Icons.attach_money,
                  label: 'Salary',
                  value: employeeModel.salary.toString(),
                ),
                _buildInfoRow(
                  icon: Icons.file_present,
                  label: 'Certificate',
                  value: employeeModel.certificate.isNotEmpty
                      ? employeeModel.certificate
                      : 'No certificate uploaded',
                  isLink: employeeModel.certificate.isNotEmpty,
                ),
                _buildInfoRow(
                  icon: Icons.date_range_outlined,
                  label: 'Hire Date',
                  value: _formatDate(employeeModel.hireDate),
                ),
                _buildInfoRow(
                  icon: Icons.person,
                  label: 'User ID',
                  value: employeeModel.userId.toString(),
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
                child: UpdateEmployeeInfoScreen(employee: employeeModel),
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
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: AppColors.darkBlue,
      ),
    );
  }
}
