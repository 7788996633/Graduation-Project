import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../blocs/user_bloc/user_bloc.dart';
import '../../../constant.dart';
import '../../widgets/auth_widgets/auth_form.dart';
import '../../widgets/auth_widgets/auth_top_blue_curved_containor.dart';
import '../../widgets/custom_error_dialog.dart';
import '../home/home_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              setState(() {
                myToken = state.token;
              });
              BlocProvider.of<UserBloc>(context).add(
                GetUserRole(),
              );
            } else if (state is AuthFail) {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) => CustomErrorDialog(
                  errorMsg: state.errmsg,
                ),
              );
            } else if (state is AuthLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserSuccess) {
              setState(() {
                myRole = state.successmsg;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.grey[200],
          body: const Stack(
            children: [
              AuthTopBlueCurvedContainor(),
              Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: AuthForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
