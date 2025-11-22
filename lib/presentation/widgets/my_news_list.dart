// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../blocs/legal_news_bloc/legal_news_bloc.dart';
// import '../../blocs/legal_news_bloc/legal_news_event.dart';
// import '../../blocs/legal_news_bloc/legal_news_state.dart';
//
// import '../../data/models/legal_news_model.dart';
// import 'legal_news_item.dart';
//
// class MyNewsList extends StatefulWidget {
//   const MyNewsList({super.key, required this.bloc});
//   final LegalNewsBloc bloc;
//
//   @override
//   State<MyNewsList> createState() => _MyNewsListState();
// }
//
// class _MyNewsListState extends State<MyNewsList> {
//   @override
//   void initState() {
//     super.initState();
//     widget.bloc.add(MySavedLegalNewsEvent()); // الحدث لتحميل أخبار المستخدم
//   }
//
//   List<LegalNewsModel>  legalNewsList = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LegalNewsBloc, LegalNewsState>(
//       listener: (context, state) {
//         if (state is LegalNewsSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 state.successMsg,
//                 style: const TextStyle(fontSize: 16),
//               ),
//               backgroundColor: Colors.green,
//             ),
//           );
//           widget.bloc.add(MySavedLegalNewsEvent());
//         } else if (state is LegalNewsFail) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 state.errMsg,
//                 style: const TextStyle(fontSize: 16),
//               ),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       },
//       child: BlocBuilder<LegalNewsBloc, LegalNewsState>(
//         builder: (context, state) {
//           if (state is LegalNewsListLoaded) {
//             legalNewsList = state.list;
//             if ( legalNewsList.isEmpty) {
//               return const Center(child: Text('There are no saved news'));
//             }
//             return Expanded(
//               child: ListView.builder(
//                 itemCount:  legalNewsList.length,
//                 itemBuilder: (context, index) {
//                   return LegalNewsItem(
//                     legalNews: legalNewsList[index],
//                   );
//                 },
//               ),
//             );
//           } else if (state is LegalNewsFail) {
//             return Column(
//               children: [
//                 const Text(
//                   "There is an error:",
//                   style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   state.errMsg,
//                   style: const TextStyle(
//                     fontSize: 30,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
