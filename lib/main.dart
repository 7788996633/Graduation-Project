import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/my_bloc_observere.dart';
import 'blocs/user_bloc/user_bloc.dart';
import 'blocs/auth_bloc/auth_bloc.dart';

import 'blocs/user_profile_bloc/user_profile_bloc.dart';
import 'presentation/screens/auth_screens/auth_screen.dart';
import 'presentation/widgets/auth_web_wedgets/auth_web_screen.dart';

import 'localnotification.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await LocalNotification.init();
    LocalNotification.ensureConnected();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
          BlocProvider(
            create: (context) => UserBloc(),
          ),
          BlocProvider(
            create: (context) => UserProfileBloc(),
          ),
        ],
        child: kIsWeb ? const AuthWebScreen() : const AuthScreen(),
      ),
    );
  }
}
