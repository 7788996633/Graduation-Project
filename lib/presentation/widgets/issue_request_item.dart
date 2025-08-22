// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
// import '../../blocs/issue_requests_bloc/issue_requests_event.dart';
// import '../../data/models/issue_request_model.dart';
// import '../screens/issue_request/issue_request_detials_screen.dart';

// class IssueRequestItem {
//   static Widget create({
//     required BuildContext context,
//     required IssueRequestModel request,
//     required IssueRequestsBloc bloc,
//   }) {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: ListTile(
//         title: Text(request.title),
//         subtitle: Text(request.description),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => BlocProvider.value(
//                 value: bloc,
//                 child: IssueRequestDetailsScreen(issueRequestId: request.id),
//               ),
//             ),
//           );
//         },
//         trailing: IconButton(
//           icon: const Icon(Icons.delete, color: Colors.red),
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 title: const Text("Delete Issue Request"),
//                 content: const Text("Are you sure you want to delete this issue request?"),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: const Text("Cancel"),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       bloc.add(DeleteIssueRequestEvent(issueRequestId: request.id));
//                           bloc.add(GetAllIssueRequestsEvent());
//                     },
//                     child: const Text("Delete", style: TextStyle(color: Colors.red)),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
