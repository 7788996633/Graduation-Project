import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../blocs/employee_bloc/employee_bloc.dart';

import '../../../../blocs/employee_bloc/employee_event.dart';
import '../../../../blocs/employee_bloc/employee_state.dart';
import '../../../../data/models/employee_model.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';

class UpdateEmployeeInfoScreen extends StatefulWidget {
  final EmployeeModel employee;

  const UpdateEmployeeInfoScreen({super.key, required this.employee});

  @override
  State<UpdateEmployeeInfoScreen> createState() => _UpdateEmployeeInfoScreenState();
}

class _UpdateEmployeeInfoScreenState extends State<UpdateEmployeeInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _salaryController;
  late TextEditingController _certificateController;

  @override
  void initState() {
    super.initState();
    _salaryController = TextEditingController(text: widget.employee.salary.toString());
    _certificateController = TextEditingController(text: widget.employee.certificate);
  }

  @override
  void dispose() {
    _salaryController.dispose();
    _certificateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomActionAppBar(title: 'Update Employee Info'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            if (state is EmployeeSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.successMsg,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(
                context,
                EmployeeModel(
                  id: widget.employee.id,
                  salary: int.parse(_salaryController.text.trim()),
                  certificate: _certificateController.text.trim(),
                  hireDate: widget.employee.hireDate,  // نحتفظ بالقيمة الأصلية
                  userId: widget.employee.userId,      // نحتفظ بالقيمة الأصلية
                ),
              );
            } else if (state is EmployeeFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errMsg,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is EmployeeLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _salaryController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Salary'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter salary' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _certificateController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Certificate (Path or Name)'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter certificate' : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final int? salary = int.tryParse(_salaryController.text.trim());
                        if (salary == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Salary must be a valid number"),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          return;
                        }

                        BlocProvider.of<EmployeeBloc>(context).add(
                          UpdateEmployeeEvent(
                            employeeId: widget.employee.id,
                            salary: salary,
                            certificate: _certificateController.text.trim(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
