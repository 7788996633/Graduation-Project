import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/payroll_bloc/payroll_bloc.dart';
import '../../../blocs/payroll_bloc/payroll_event.dart';
import '../../widgets/build_custom_appbar_detials.dart';
import '../../widgets/custom_text_field_add.dart';
import '../../widgets/elevated_button_submit.dart';

class AddPayrollScreen extends StatefulWidget {
  const AddPayrollScreen({super.key});

  @override
  State<AddPayrollScreen> createState() => _AddPayrollScreenState();
}

class _AddPayrollScreenState extends State<AddPayrollScreen> {
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: buildCustomAppBar("Add Payroll"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<PayrollBloc, PayrollState>(
          listener: (context, state) {
            if (state is PayrollSuccess) {
              _employeeIdController.clear();
              _salaryController.clear();
              _descriptionController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successMsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is PayrollFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed: ${state.errMsg}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Create New Payroll",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    CustomTextFieldAdd(
                      controller: _employeeIdController,
                      label: 'Employee ID',
                    ),
                    const SizedBox(height: 20),
                    CustomTextFieldAdd(
                      controller: _salaryController,
                      label: 'Salary',
                    ),
                    const SizedBox(height: 20),
                    CustomTextFieldAdd(
                      controller: _descriptionController,
                      label: 'Description',
                      maxLines: 5,
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    const SizedBox(height: 30),
                    state is PayrollLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                      height: 50,
                      child: CustomElevatedButtonSubmit(
                        label: "Submit",
                        onPressed: () {
                          BlocProvider.of<PayrollBloc>(context).add(
                            AddPayrollEvent(
                              employeeId: int.tryParse(_employeeIdController.text.trim()) ?? 0,
                              salary: double.tryParse(_salaryController.text.trim()) ?? 0.0,
                              description: _descriptionController.text.trim(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
