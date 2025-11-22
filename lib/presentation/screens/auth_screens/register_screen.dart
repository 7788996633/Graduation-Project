// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation/blocs/user_profile_bloc/user_profile_bloc.dart';
// import 'package:graduation/presentation/screens/user_screens/user_profile_screens/create_user_profile_screen.dart';

// import '../../../blocs/auth_bloc/auth_bloc.dart';
// import '../../../blocs/user_bloc/user_bloc.dart';
// import '../../../constant.dart';
// import '../../widgets/custom_text_field.dart';
// import 'login_screen.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   final GlobalKey<FormState> myKey = GlobalKey<FormState>();

//   String? nameValidator(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter your name';
//     }
//     return null;
//   }

//   String? emailValidator(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter your email';
//     }
//     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
//       return 'Please enter a valid email address';
//     }
//     return null;
//   }

//   String? passwordValidator(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter your password';
//     }
//     if (value.length < 8) {
//       return 'Password must be at least 8 characters long';
//     }
//     return null;
//   }

//   String? confirmPasswordValidator(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please confirm your password';
//     }
//     if (value != passwordController.text) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   void handleRegister() {
//     if (myKey.currentState?.validate() ?? false) {
//       BlocProvider.of<AuthBloc>(context).add(
//         RegisterEvent(
//           confirmPassword: confirmPasswordController.text.trim(),
//           name: nameController.text.trim(),
//           email: emailController.text.trim(),
//           password: passwordController.text,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthSuccess) {
//           setState(() {
//             myToken = state.token;
//             myRole = 'user';
//           });
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => BlocProvider(
//                 create: (context) => UserProfileBloc(),
//                 child: const CreateUserProfileScreen(),
//               ),
//             ),
//           );
//         } else if (state is AuthFail) {
//           Navigator.of(context).pop();
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               backgroundColor: const Color.fromARGB(255, 146, 100, 239),
//               content: Text(
//                 state.errmsg,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           );
//         } else if (state is AuthLoading) {
//           showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (context) => const Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//       },
//       builder: (context, state) => Scaffold(
//         backgroundColor: Colors.grey[200],
//         body: Stack(
//           children: [
//             // Top blue curved container
//             Container(
//               height: 250,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Color(0xFF2196F3),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//               ),
//             ),

//             // Register form
//             Align(
//               alignment: Alignment.center,
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Form(
//                   key: myKey,
//                   child: Container(
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 10,
//                           offset: const Offset(0, 5),
//                         )
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Text(
//                           "Register",
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         CustomTextFeild(
//                           color: Colors.grey[200]!,
//                           validator: nameValidator,
//                           controller: nameController,
//                           text: "Name",
//                         ),
//                         const SizedBox(height: 12),
//                         CustomTextFeild(
//                           color: Colors.grey[200]!,
//                           validator: emailValidator,
//                           controller: emailController,
//                           text: "Email",
//                         ),
//                         const SizedBox(height: 12),
//                         CustomTextFeild(
//                           color: Colors.grey[200]!,
//                           validator: passwordValidator,
//                           controller: passwordController,
//                           text: "Password",
//                         ),
//                         const SizedBox(height: 12),
//                         CustomTextFeild(
//                           color: Colors.grey[200]!,
//                           validator: confirmPasswordValidator,
//                           controller: confirmPasswordController,
//                           text: "Confirm Password",
//                         ),
//                         const SizedBox(height: 16),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF2196F3),
//                               padding: const EdgeInsets.symmetric(vertical: 14),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             onPressed: handleRegister,
//                             child: const Text(
//                               "Register",
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         const Divider(),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               "Already have an account? ",
//                               style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 14,
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pushReplacement(
//                                   MaterialPageRoute(
//                                     builder: (context) => MultiBlocProvider(
//                                       providers: [
//                                         BlocProvider(
//                                           create: (context) => AuthBloc(),
//                                         ),
//                                         BlocProvider(
//                                           create: (context) => UserBloc(),
//                                         ),
//                                       ],
//                                       child: const LoginScreen(),
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: const Text(
//                                 "Login",
//                                 style: TextStyle(
//                                   color: Color(0xFF2196F3),
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
