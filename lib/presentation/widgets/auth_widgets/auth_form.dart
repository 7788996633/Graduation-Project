import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../constant.dart';
import '../../../validator.dart';
import '../custom_text_field.dart';
import 'login_column.dart';
import 'register_column.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool isLogin = true;
  bool isSubmitting = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> myKey = GlobalKey<FormState>();

  void handleLogin() {
    if (myKey.currentState?.validate() ?? false) {
      BlocProvider.of<AuthBloc>(context).add(
        LoginEvent(
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );
    }
  }

  void handleRegister() {
    if (myKey.currentState?.validate() ?? false) {
      BlocProvider.of<AuthBloc>(context).add(
        RegisterEvent(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text.trim(),
        ),
      );
    }
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        setState(
          () => isSubmitting = state is AuthLoading,
        );
      },
      child: Form(
        key: myKey,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isLogin ? "Login" : "Register",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (!isLogin)
                CustomTextFeild(
                  color: Colors.grey[200]!,
                  validator: Validator.nameValidator,
                  controller: nameController,
                  text: "Name",
                ),
              if (!isLogin) const SizedBox(height: 12),
              CustomTextFeild(
                color: Colors.grey[200]!,
                validator: Validator.emailValidator,
                controller: emailController,
                text: "Email",
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                color: Colors.grey[200]!,
                validator: Validator.passwordValidator,
                controller: passwordController,
                text: "Password",
              ),
              if (!isLogin) const SizedBox(height: 12),
              if (!isLogin)
                CustomTextFeild(
                  color: Colors.grey[200]!,
                  validator: (value) => Validator.confirmPasswordValidator(
                    confirmPasswordController.text,
                    passwordController.text,
                  ),
                  controller: confirmPasswordController,
                  text: "Confirm Password",
                ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSubmitting
                      ? null
                      : isLogin
                          ? handleLogin
                          : handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isSubmitting
                        ? "Loading..."
                        : (isLogin ? "Login" : "Register"),
                    style: const TextStyle(fontSize: 16,color: AppColors.white,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              isLogin
                  ? LoginColumn(
                      onPressed: () {
                        setState(() {
                          isLogin = false;
                          clearControllers();
                        });
                      },
                    )
                  : RegisterColumn(
                      onPressed: () {
                        setState(
                          () {
                            isLogin = true;
                            clearControllers();
                          },
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
