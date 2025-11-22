import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/presentation/screens/user_screens/user_profile_screens/create_user_profile_screen.dart';
import 'package:graduation/presentation/screens/lawyer_screens/lawyer_profile_screens/create_lawyer_profile_screen.dart';

import '../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../../blocs/user_bloc/user_bloc.dart';
import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../../constant.dart';
import '../../../themes.dart';
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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthSuccess) {
          // خزّن التوكن
          myToken = state.token;

          // 1) جيب الدور
          final userBloc = BlocProvider.of<UserBloc>(context);
          userBloc.add(GetUserRole());

          final userState = await userBloc.stream.firstWhere(
            (s) => s is UserSuccess || s is UserFail,
          );

          if (userState is UserSuccess) {
            myRole = userState.successmsg;

            // 2) جيب البروفايل
            final userProfileBloc = BlocProvider.of<UserProfileBloc>(context);
            userProfileBloc.add(ShowUserProfileEvent());

            final profileState = await userProfileBloc.stream.firstWhere(
              (s) => s is UserProfileLoadedSuccessfully || s is UserProfileFail,
            );

            if (profileState is UserProfileLoadedSuccessfully) {
              myUserId = profileState.userProfileModel.userId;

              // 3) إذا محامي → جيب بروفايل المحامي
              if (myRole == "lawyer") {
                final lawyerBloc = BlocProvider.of<LawyerProfileBloc>(context);
                lawyerBloc.add(ShowLawyerProfileEvent());

                final lawyerState = await lawyerBloc.stream.firstWhere((s) =>
                    s is LawyerProfileLoadedSuccessfully ||
                    s is LawyerProfileFail);

                if (lawyerState is LawyerProfileLoadedSuccessfully) {
                  myLicenesNumber = lawyerState.lawyerModel.licenseNumber;

                  // 🚀 بعد اكتمال كل شي → التنقّل
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false,
                  );
                } else if (lawyerState is LawyerProfileFail) {
                  // إذا المحامي ما عندو بروفايل → خدو على شاشة إنشاء بروفايل محامي
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (_) => const CreateLawyerProfileScreen()),
                    (route) => false,
                  );
                }
              } else {
                // 🚀 باقي الأدوار (user, admin) → روح عالهوم
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false,
                );
              }
            } else if (profileState is UserProfileFail && myRole == "user") {
              // إذا مستخدم عادي وما عندو بروفايل → روح ع شاشة إنشاء بروفايل يوزر
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (_) => const CreateUserProfileScreen()),
                (route) => false,
              );
            }
          }
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
      builder: (context, state) => Scaffold(
        backgroundColor: AppColors.scaffold,
        body: Stack(
          children: [
            AuthTopBlueCurvedContainor(),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: const AuthForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
