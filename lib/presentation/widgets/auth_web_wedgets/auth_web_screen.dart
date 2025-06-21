import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../constant.dart';
import '../../screens/home_web/home_web_page.dart';
import '../../widgets/auth_widgets/auth_form.dart';
import '../../widgets/custom_error_dialog.dart';

class AuthWebScreen extends StatefulWidget {
  const AuthWebScreen({super.key});

  @override
  State<AuthWebScreen> createState() => _AuthWebScreenState();
}

class _AuthWebScreenState extends State<AuthWebScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1565C0)),
                    strokeWidth: 4,
                  ),
                ),
              );
            } else if (state is AuthFail) {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (_) => CustomErrorDialog(errorMsg: state.errmsg),
              );
            } else if (state is AuthSuccess) {
              Navigator.of(context).pop();
              setState(() {
                myToken = state.token;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeWebPage()),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F5F5),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(48),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
          child: Card(
          color: Colors.white,
         elevation: 24,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
         shadowColor: Colors.black.withOpacity(0.3),
         child: Padding(
         padding: const EdgeInsets.all(32.0),
         child: LayoutBuilder(
         builder: (context, constraints) {

                          if (constraints.maxWidth < 700) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'assets/images/grad.jpg',
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 32),
                                const AuthForm(),
                              ],
                            );
                          } else {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      'assets/images/grad.jpg',
                                      height: 350,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 32),

                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: const AuthForm(),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
