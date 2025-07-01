import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/employee_bloc/employee_bloc.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  File? selectedFile;

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إضافة موظف')),
      body: BlocConsumer<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
          if (state is EmployeeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successmsg)),
            );
          } else if (state is EmployeeFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errmsg)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                    controller: idController,
                    decoration: InputDecoration(labelText: 'ID')),
                TextField(
                    controller: salaryController,
                    decoration: InputDecoration(labelText: 'Salary')),
                TextField(
                    controller: typeController,
                    decoration: InputDecoration(labelText: 'Type')),
                ElevatedButton(onPressed: pickFile, child: Text("اختيار ملف")),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (selectedFile != null) {
                      context.read<EmployeeBloc>().add(AddEmployeeEvent(
                            id: int.parse(idController.text),
                            salary: salaryController.text,
                            file: selectedFile!,
                            type: typeController.text,
                          ));
                    }
                  },
                  child: Text("إضافة"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
