// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation/presentation/screens/home/home_page.dart';
// import 'package:graduation/validator.dart';
// import '../../../blocs/auth_bloc/auth_bloc.dart';
// import '../../../blocs/user_bloc/user_bloc.dart';
// import '../../../constant.dart';
// import '../../widgets/auth_widgets/auth_top_blue_curved_containor.dart';
// import '../../widgets/custom_text_field.dart';
// import 'register_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final GlobalKey<FormState> myKey = GlobalKey<FormState>();

//   void handleLogin() {
//     if (myKey.currentState?.validate() ?? false) {
//       BlocProvider.of<AuthBloc>(context).add(
//         LoginEvent(
//           email: emailController.text,
//           password: passwordController.text,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<AuthBloc, AuthState>(
//           listener: (context, state) {
//             if (state is AuthSuccess) {
//               setState(() {
//                 myToken = state.token;
//               });
//               BlocProvider.of<UserBloc>(context).add(
//                 GetUserRole(),
//               );
//             } else if (state is AuthFail) {
//               Navigator.of(context).pop();
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   backgroundColor: const Color.fromARGB(255, 146, 100, 239),
//                   content: Text(
//                     state.errmsg,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               );
//             } else if (state is AuthLoading) {
//               showDialog(
//                 context: context,
//                 barrierDismissible: false,
//                 builder: (context) => const Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             }
//           },
//         ),
//         BlocListener<UserBloc, UserState>(
//           listener: (context, state) {
//             if (state is UserSuccess) {
//               setState(() {
//                 myRole = state.successmsg;
//               });
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => const HomePage(),
//                 ),
//               );
//             }
//           },
//         ),
//       ],
//       child: BlocBuilder<AuthBloc, AuthState>(
//         builder: (context, state) => Scaffold(
//           backgroundColor: Colors.grey[200],
//           body: Stack(
//             children: [
//               const AuthTopBlueCurvedContainor(), // Login form
//               Align(
//                 alignment: Alignment.center,
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Form(
//                     key: myKey,
//                     child: Container(
//                       padding: const EdgeInsets.all(24),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(30),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           )
//                         ],
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Text(
//                             "Login",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           CustomTextFeild(
//                             color: Colors.grey[200]!,
//                             validator: Validator.emailValidator,
//                             controller: emailController,
//                             text: "Email",
//                           ),
//                           const SizedBox(height: 12),
//                           CustomTextFeild(
//                             color: Colors.grey[200]!,
//                             validator: Validator.passwordValidator,
//                             controller: passwordController,
//                             text: "Password",
//                           ),
//                           const SizedBox(height: 16),
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF2196F3),
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 14),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               onPressed: handleLogin,
//                               child: const Text(
//                                 "Login",
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           TextButton(
//                             onPressed: () {},
//                             child: const Text(
//                               "Forgot password?",
//                               style: TextStyle(color: Colors.black54),
//                             ),
//                           ),
//                           const Divider(),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pushReplacement(
//                                 MaterialPageRoute(
//                                   builder: (context) => BlocProvider(
//                                     create: (context) => AuthBloc(),
//                                     child: const RegisterScreen(),
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: const Text(
//                               "Create a new account",
//                               style: TextStyle(color: Colors.blue),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
