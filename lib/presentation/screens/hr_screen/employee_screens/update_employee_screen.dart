import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/employee_bloc/employee_bloc.dart';
import '../../../../blocs/employee_bloc/employee_event.dart';
import '../../../../blocs/employee_bloc/employee_state.dart';
import '../../../../data/models/employee_model.dart';
import '../../../../themes.dart';

class UpdateEmployeeInfoScreen extends StatefulWidget {
  final EmployeeModel employee;

  const UpdateEmployeeInfoScreen({super.key, required this.employee});

  @override
  State<UpdateEmployeeInfoScreen> createState() => _UpdateEmployeeInfoScreenState();
}

class _UpdateEmployeeInfoScreenState extends State<UpdateEmployeeInfoScreen> {
  late TextEditingController _salaryController;
  String? _selectedCertificatePath;

  @override
  void initState() {
    super.initState();
    _salaryController = TextEditingController(text: widget.employee.salary.toString());
    _selectedCertificatePath = widget.employee.certificate; // القيمة الأصلية إن وجدت
  }

  @override
  void dispose() {
    _salaryController.dispose();
    super.dispose();
  }

  Future<void> _pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedCertificatePath = result.files.single.path!;
      });
    } else {
      // تم الإلغاء
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تحديث بيانات الموظف'),
          backgroundColor: AppColors.darkBlue,
        ),
        body: BlocConsumer<EmployeeBloc, EmployeeState>(
          listener: (context, state) {
            if (state is EmployeeSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ ${state.successMsg}')),
              );
              Navigator.pop(
                context,
                EmployeeModel(
                  id: widget.employee.id,
                  salary: int.parse(_salaryController.text.trim()),
                  certificate: _selectedCertificatePath ?? '',
                  hireDate: widget.employee.hireDate,
                  userId: widget.employee.userId,
                ),
              );
            } else if (state is EmployeeFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errMsg}')),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('ID: ${widget.employee.id}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _salaryController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'الراتب',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // زر تحميل الشهادة
                  ElevatedButton.icon(
                    onPressed: _pickPdfFile,
                    icon: const Icon(Icons.attach_file),
                    label: const Text('تحميل شهادة (PDF)'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                  ),
                  if (_selectedCertificatePath != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '📄 الملف المختار: ${_selectedCertificatePath!.split('/').last}',
                        style: const TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ),

                  const SizedBox(height: 30),
                  state is EmployeeLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () {
                      final salary = int.tryParse(_salaryController.text.trim());
                      if (salary == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("⚠️ الراتب يجب أن يكون رقماً صحيحاً"),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        return;
                      }

                      if (_selectedCertificatePath == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("⚠️ يرجى تحميل ملف الشهادة"),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        return;
                      }

                      BlocProvider.of<EmployeeBloc>(context).add(
                        UpdateEmployeeEvent(
                          employeeId: widget.employee.id,
                          salary: salary,
                          certificate: _selectedCertificatePath!,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    ),
                    child: const Text(
                      'تحديث البيانات',
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
