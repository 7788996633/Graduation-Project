import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../constant.dart';
import '../../../validator.dart';
import '../auth_widgets/login_column.dart';
import '../auth_widgets/register_column.dart';
import '../custom_text_field.dart';


class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool isLogin = true;
  bool isSubmitting = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void handleSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      setState(() => isSubmitting = true);
      if (isLogin) {
        BlocProvider.of<AuthBloc>(context).add(
          LoginEvent(email: emailController.text, password: passwordController.text),
        );
      } else {
        BlocProvider.of<AuthBloc>(context).add(
          RegisterEvent(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
            confirmPassword: confirmPasswordController.text,
          ),
        );
      }
    }
  }

  void clearAll() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        setState(() => isSubmitting = state is AuthLoading);
      },
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isLogin)
              CustomTextFeild(
                controller: nameController,
                validator: Validator.nameValidator,
                text: "Name",
                color: Colors.grey[200]!,
              ),
            const SizedBox(height: 12),
            CustomTextFeild(
              controller: emailController,
              validator: Validator.emailValidator,
              text: "Email",
              color: Colors.grey[200]!,
            ),
            const SizedBox(height: 12),
            CustomTextFeild(
              controller: passwordController,
              validator: Validator.passwordValidator,
              text: "Password",
              color: Colors.grey[200]!,
            ),
            const SizedBox(height: 12),
            if (!isLogin)
              CustomTextFeild(
                controller: confirmPasswordController,
                validator: (value) => Validator.confirmPasswordValidator(
                  confirmPasswordController.text,
                  passwordController.text,
                ),
                text: "Confirm Password",
                color: Colors.grey[200]!,
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSubmitting ? null : handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBlue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  isSubmitting
                      ? "Loading..."
                      : isLogin
                      ? "Login"
                      : "Register",
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            isLogin
                ? LoginColumn(onPressed: () {
              setState(() {
                isLogin = false;
                clearAll();
              });
            })
                : RegisterColumn(onPressed: () {
              setState(() {
                isLogin = true;
                clearAll();
              });
            }),
          ],
        ),
      ),
    );
  }
}
