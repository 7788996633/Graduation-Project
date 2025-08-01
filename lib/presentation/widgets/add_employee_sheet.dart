// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation/blocs/employee_bloc/employee_bloc.dart';
// import 'dart:io';

// import 'custom_text_field.dart';

// class AddEmployeeSheet extends StatefulWidget {
//   const AddEmployeeSheet(
//       {super.key, required this.selectedRole, required this.id});
//   final String selectedRole;
//   final int id;
//   @override
//   State<AddEmployeeSheet> createState() => _AddEmployeeSheetState();
// }

// class _AddEmployeeSheetState extends State<AddEmployeeSheet> {
//   TextEditingController salaryController = TextEditingController();
//   GlobalKey<FormState> myKey = GlobalKey<FormState>();

//   File? selectedFile;

//   String? salaryValidator(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter salary';
//     }
//     return null;
//   }

//   Future<void> pickCertificateFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();

//     if (result != null && result.files.single.path != null) {
//       setState(() {
//         selectedFile = File(result.files.single.path!);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       color: Colors.black54,
//       height: MediaQuery.sizeOf(context).height * 0.5,
//       width: double.infinity,
//       child: Form(
//         key: myKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(widget.selectedRole == 'HR'
//                 ? "Add As A HR"
//                 : "Add As An Accountant"),
//             CustomTextFeild(
//               text: 'Salary',
//               controller: salaryController,
//               validator: salaryValidator,
//               color: widget.selectedRole == 'HR'
//                   ? Colors.yellowAccent
//                   : Colors.greenAccent,
//             ),
//             MaterialButton(
//               color: widget.selectedRole == 'HR'
//                   ? Colors.yellowAccent
//                   : Colors.greenAccent,
//               onPressed: pickCertificateFile,
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Add certificates "),
//                   Icon(Icons.upload_file),
//                 ],
//               ),
//             ),
//             if (selectedFile != null)
//               Text(
//                 'Selected: ${selectedFile!.path.split('/').last}',
//                 style: const TextStyle(color: Colors.white),
//               ),
//             BlocConsumer<EmployeeBloc, EmployeeState>(
//               listener: (context, state) {
//                 if (state is EmployeeSuccess) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(
//                         state.successmsg,
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                       backgroundColor: Colors.green,
//                     ),
//                   );
//                   Navigator.of(context).pop();
//                 } else if (state is EmployeeFail) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(
//                         state.errmsg,
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                       backgroundColor: Colors.red,
//                     ),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 return ElevatedButton(
//                   onPressed: () {
//                     if (myKey.currentState!.validate()) {
//                       BlocProvider.of<EmployeeBloc>(context).add(
//                         AddEmployeeEvent(
//                             file: selectedFile!,
//                             salary: salaryController.text,
//                             id: widget.id,
//                             type: widget.selectedRole),
//                       );
//                     }
//                   },
//                   child: const Text("Add"),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
