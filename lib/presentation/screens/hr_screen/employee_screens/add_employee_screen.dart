import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/employee_bloc/employee_bloc.dart';
import '../../../../blocs/employee_bloc/employee_event.dart';
import '../../../../blocs/employee_bloc/employee_state.dart';
import '../../../widgets/build_custom_appbar_detials.dart';
import '../../../widgets/custom_text_field_add.dart';
import '../../../widgets/elevated_button_submit.dart';

class AddEmployeeScreen extends StatefulWidget {
  final int userId;

  const AddEmployeeScreen({super.key, required this.userId});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _hireDateController = TextEditingController();
  String? _selectedType;
  File? _certificateFile;

  final List<String> _employeeTypes = ['HR', 'accountant', 'lawyer'];

  void _clearFields() {
    _salaryController.clear();
    _hireDateController.clear();
    _selectedType = null;
    _certificateFile = null;
    setState(() {});
  }

  @override
  void dispose() {
    _salaryController.dispose();
    _hireDateController.dispose();
    super.dispose();
  }

  Future<void> _selectHireDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _hireDateController.text =
        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _certificateFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: buildCustomAppBar("Add Employee"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            if (state is EmployeeSuccess) {
              _clearFields();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.successMsg),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is EmployeeFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMsg),
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
                      "Create New Employee",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    CustomTextFieldAdd(
                      controller: _salaryController,
                      label: 'Salary',
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedType,
                      items: _employeeTypes
                          .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    /// Certificate PDF picker
                    GestureDetector(
                      onTap: _pickPDF,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.picture_as_pdf, color: Colors.red),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _certificateFile != null
                                    ? _certificateFile!.path.split('/').last
                                    : 'Upload Certificate (PDF)',
                                style: TextStyle(
                                  color: _certificateFile != null
                                      ? Colors.black
                                      : Colors.grey.shade600,
                                ),
                              ),
                            ),
                            const Icon(Icons.upload_file, color: Colors.blue),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    /// Hire Date picker
                    GestureDetector(
                      onTap: () => _selectHireDate(context),
                      child: AbsorbPointer(
                        child: CustomTextFieldAdd(
                          controller: _hireDateController,
                          label: 'Hire Date',
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    state is EmployeeLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                      height: 50,
                      child: CustomElevatedButtonSubmit(
                        label: "Submit Employee",
                        onPressed: () {
                          if (_salaryController.text.isEmpty ||
                              _selectedType == null ||
                              _certificateFile == null ||
                              _hireDateController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please fill in all fields."),
                                backgroundColor: Colors.orange,
                              ),
                            );
                            return;
                          }

                          final int? salary =
                          int.tryParse(_salaryController.text.trim());
                          if (salary == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                Text("Salary must be a valid number."),
                                backgroundColor: Colors.orange,
                              ),
                            );
                            return;
                          }

                          if (!_employeeTypes.contains(_selectedType)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                Text("Please select a valid employee type."),
                                backgroundColor: Colors.orange,
                              ),
                            );
                            return;
                          }

                          final String certificateFileName =
                              _certificateFile!.path.split('/').last;

                          BlocProvider.of<EmployeeBloc>(context).add(
                            CreateEmployeeEvent(
                              userId: widget.userId,
                              salary: salary,
                              hireDate: _hireDateController.text.trim(),
                              certificate: _certificateFile!,
                              certificateFileName: certificateFileName,
                              type: _selectedType!,
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
