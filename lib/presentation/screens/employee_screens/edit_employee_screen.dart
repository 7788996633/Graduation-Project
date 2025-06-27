import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/employee_bloc/employee_bloc.dart';

class EditEmployeeScreen extends StatefulWidget {
  const EditEmployeeScreen({super.key});

  @override
  _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
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
      appBar: AppBar(title: Text("تعديل موظف")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: idController,
                decoration: InputDecoration(labelText: 'ID')),
            TextField(
                controller: salaryController,
                decoration: InputDecoration(labelText: 'الراتب')),
            ElevatedButton(onPressed: pickFile, child: Text("اختيار ملف جديد")),
            ElevatedButton(
              onPressed: () {
                if (selectedFile != null) {
                  context.read<EmployeeBloc>().add(EditEmployeeEvent(
                        employeeId: int.parse(idController.text),
                        salary: salaryController.text,
                        file: selectedFile!,
                      ));
                }
              },
              child: Text("تحديث"),
            ),
          ],
        ),
      ),
    );
  }
}
