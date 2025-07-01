import 'blocs/my_bloc_observere.dart';
import 'package:flutter/material.dart';
import 'blocs/user_bloc/user_bloc.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/localnotification.dart';
import 'package:graduation/presentation/screens/auth_screens/auth_screen.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
  LocalNotification.init();
 LocalNotification.ensureConnected();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        ],
        child: const AuthScreen(),
      ),
    );
  }
}
