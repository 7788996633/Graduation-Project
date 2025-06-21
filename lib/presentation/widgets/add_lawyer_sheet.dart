// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:path/path.dart';
// import '../../blocs/add_lawyer_sheet/add_lawyer_bloc.dart';
// import '../../blocs/add_lawyer_sheet/add_lawyer_event.dart';
// import '../../blocs/add_lawyer_sheet/add_lawyer_state.dart';
// import '../../constant.dart';
// import '../../data/repositories/users_repositories.dart';
// import '../../data/services/add_lawyer_service.dart';
// import '../widgets/custom_text_field.dart';
// import '../../data/models/user_model.dart';

// class AddLawyerSheet extends StatefulWidget {
//   const AddLawyerSheet({super.key});

//   @override
//   State<AddLawyerSheet> createState() => _AddLawyerSheetState();
// }

// class _AddLawyerSheetState extends State<AddLawyerSheet> {
//   final TextEditingController licenseNumberController = TextEditingController();
//   final TextEditingController experienceYearsController = TextEditingController();
//   final TextEditingController specializationController = TextEditingController();
//   final TextEditingController salaryController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   String? certificateFilePath;
//   String? resultMessage;

//   String? nameValidator(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'This field is required';
//     }
//     return null;
//   }

//   Future<void> _pickCertificate() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'jpg', 'png', 'docx'],
//     );

//     if (result != null) {
//       setState(() {
//         certificateFilePath = result.files.single.path;
//       });
//       print("📎 Certificate file selected: $certificateFilePath");
//     } else {
//       print("📭 No file selected");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<UserModel>(
//       future: UsersRepositories().getAllUsers().then((users) => users.first),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }

//         if (!snapshot.hasData) {
//           return const Center(child: Text('No user data available'));
//         }

//         final user = snapshot.data!;

//         return BlocProvider(
//           create: (_) => AddLawyerBloc(
//             service: AddLawyerService(),
//             userId: user.id,
//             token: myToken,
//           ),
//           child: BlocListener<AddLawyerBloc, AddLawyerState>(
//             listener: (context, state) {
//               if (state is AddLawyerLoading) {
//                 setState(() {
//                   resultMessage = "Uploading... ";
//                 });
//               } else if (state is AddLawyerSuccess) {
//                 setState(() {
//                   resultMessage = "Upload successful ";
//                 });
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text("Upload successful "),
//                     backgroundColor: Colors.green,
//                   ),
//                 );
//               } else if (state is AddLawyerFailure) {
//                 setState(() {
//                   resultMessage = "Error: ${state.error}";
//                 });
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text("Error: ${state.error}"),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//               }
//             },
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               color: Colors.black54,
//               height: MediaQuery.of(context).size.height * 0.7,
//               width: double.infinity,
//               child: Form(
//                 key: formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Add As A Lawyer",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                       const SizedBox(height: 16),
//                       CustomTextFeild(
//                         text: 'License Number',
//                         controller: licenseNumberController,
//                         validator: nameValidator,
//                         color: Colors.brown,
//                       ),
//                       const SizedBox(height: 10),
//                       CustomTextFeild(
//                         text: 'Experience Years',
//                         controller: experienceYearsController,
//                         validator: nameValidator,
//                         color: Colors.brown,
//                       ),
//                       const SizedBox(height: 10),
//                       CustomTextFeild(
//                         text: 'Specialization',
//                         controller: specializationController,
//                         validator: nameValidator,
//                         color: Colors.brown,
//                       ),
//                       const SizedBox(height: 10),
//                       CustomTextFeild(
//                         text: 'Salary',
//                         controller: salaryController,
//                         validator: nameValidator,
//                         color: Colors.brown,
//                       ),
//                       const SizedBox(height: 10),
//                       MaterialButton(
//                         color: Colors.brown,
//                         onPressed: _pickCertificate,
//                         child: const Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("Add certificates "),
//                             Icon(Icons.upload_file),
//                           ],
//                         ),
//                       ),
//                       if (certificateFilePath != null)
//                         Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: Text(
//                             "📎 File: ${basename(certificateFilePath!)}",
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       const SizedBox(height: 10),
//                       ElevatedButton(
//                         onPressed: () {
//                           if (formKey.currentState?.validate() ?? false) {
//                             if (certificateFilePath == null) {
//                               setState(() {
//                                 resultMessage = "Please select a certificate file first.";
//                               });
//                               return;
//                             }

//                             BlocProvider.of<AddLawyerBloc>(context).add(
//                               SubmitLawyerData(
//                                 licenseNumber: licenseNumberController.text,
//                                 experienceYears: experienceYearsController.text,
//                                 specialization: specializationController.text,
//                                 salary: salaryController.text,
//                                 type: 'Lawyer',
//                                 filePath: certificateFilePath!,
//                               ),
//                             );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.brown,
//                           foregroundColor: Colors.white,
//                         ),
//                         child: const Text('Submit'),
//                       ),
//                       if (resultMessage != null) ...[
//                         const SizedBox(height: 10),
//                         Text(
//                           resultMessage!,
//                           style: TextStyle(
//                             color: resultMessage!.startsWith("Error") ? Colors.red : Colors.green,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
