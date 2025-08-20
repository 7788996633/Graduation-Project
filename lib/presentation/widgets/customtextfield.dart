// import 'package:flutter/material.dart';

// class CustomTextFeild extends StatelessWidget {
//   const CustomTextFeild({
//     super.key,
//     required this.text,
//     required this.controller,
//     required this.validator,
//     required this.color,
//   });

//   final String text;
//   final TextEditingController controller;
//   final String? Function(String?)? validator;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: Container(
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(15), // جعل الحواف دائرية
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2), // لون الظل
//               offset: const Offset(0, 2), // موضع الظل
//               blurRadius: 6, // كثافة الظل
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: TextFormField(
//           validator: validator,
//           controller: controller,
//           style: const TextStyle(color: Colors.black),
//           decoration: InputDecoration(
//             hintText: text,
//             hintStyle: const TextStyle(color: Colors.black),
//             border: InputBorder.none, // لا يوجد إطار
//           ),

//         ),
//       ),
//     );
//   }
// }
