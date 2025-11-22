// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../blocs/issue_progress_reports/issue_progress_reports_bloc.dart';
// import '../../../blocs/issue_progress_reports/issue_progress_reports_event.dart';
// import '../../../blocs/issue_progress_reports/issue_progress_reports_state.dart';

// import '../../widgets/build_custom_appbar_detials.dart';
// import '../../widgets/custom_text_field_add.dart';
// import '../../widgets/elevated_button_submit.dart';

// class AddIssueProgressReportScreen extends StatefulWidget {
//   const AddIssueProgressReportScreen({super.key});

//   @override
//   State<AddIssueProgressReportScreen> createState() => _AddIssueProgressReportScreenState();
// }

// class _AddIssueProgressReportScreenState extends State<AddIssueProgressReportScreen> {
//   final TextEditingController _reportController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F7FA),
//       appBar: buildCustomAppBar("Add Issue Progress Report"),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: BlocConsumer<IssueProgressReportBloc, IssueProgressReportState>(
//           listener: (context, state) {
//             if (state is IssueProgressReportSuccess) {
//               _reportController.clear();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text("Success: ${state.successMsg}"),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             } else if (state is IssueProgressReportFail) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text("Failed: ${state.errMsg}"),
//                   backgroundColor: Colors.red,
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             return SingleChildScrollView(
//               child: Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 12,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const Text(
//                       "Create New Report",
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 25),
//                     CustomTextFieldAdd(
//                       controller: _reportController,
//                       label: 'Report',
//                       maxLines: 5,
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                     ),
//                     const SizedBox(height: 30),
//                     state is IssueProgressReportLoading
//                         ? const Center(child: CircularProgressIndicator())
//                         : SizedBox(
//                       height: 50,
//                       child: CustomElevatedButtonSubmit(
//                         label: "Submit",
//                         onPressed: () {
//                           BlocProvider.of<IssueProgressReportBloc>(context).add(
//                             AddIssueProgressReportEvent(
//                               report: _reportController.text.trim(),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
