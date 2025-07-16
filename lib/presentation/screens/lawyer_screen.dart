// // presentation/screen/LawyerScreen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../blocs/lawyer/lawyer_bloc.dart';
// import '../../blocs/lawyer/lawyer_event.dart';
// import '../../blocs/lawyer/lawyer_state.dart';

// class LawyerScreen extends StatefulWidget {
//   const LawyerScreen({super.key});

//   @override
//   State<LawyerScreen> createState() => _LawyerScreenState();
// }

// class _LawyerScreenState extends State<LawyerScreen> {
//   final TextEditingController _idController = TextEditingController();

//   @override
//   void dispose() {
//     _idController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => LawyerBloc()..add(FetchAllLawyers()), // جلب كل المحامين مباشرة
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Lawyers')),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _idController,
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(
//                         labelText: "Enter Lawyer ID",
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       final id = int.tryParse(_idController.text);
//                       if (id != null) {
//                         context.read<LawyerBloc>().add(FetchLawyerById(id));
//                       }
//                     },
//                     child: const Text("Search"),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: BlocBuilder<LawyerBloc, LawyerState>(
//                   builder: (context, state) {
//                     if (state is LawyerLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (state is LawyersLoaded) {
//                       return ListView.builder(
//                         itemCount: state.lawyers.length,
//                         itemBuilder: (context, index) {
//                           final lawyer = state.lawyers[index];
//                           return ListTile(
//                             leading: const Icon(Icons.person),
//                             title: Text("License: ${lawyer.licenseNumber}"),
//                             subtitle: Text(
//                               "${lawyer.specialization} • ${lawyer.experienceYears} yrs • ${lawyer.salary} \$",
//                             ),
//                             trailing: Text(lawyer.certificate),
//                           );
//                         },
//                       );
//                     } else if (state is LawyerLoaded) {
//                       final lawyer = state.lawyer;
//                       return ListTile(
//                         title: Text("License: ${lawyer.licenseNumber}"),
//                         subtitle: Text(
//                           "${lawyer.specialization} • ${lawyer.experienceYears} yrs • ${lawyer.salary} \$",
//                         ),
//                         trailing: Text(lawyer.certificate),
//                       );
//                     } else if (state is LawyerError) {
//                       return Center(child: Text("Error: ${state.message}"));
//                     }
//                     return const Center(child: Text("Enter an ID to search for a lawyer."));
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
