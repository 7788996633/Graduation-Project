import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'blocs/my_bloc_observere.dart';
import 'blocs/user_bloc/user_bloc.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/user_profile_bloc/user_profile_bloc.dart';

import 'firebase_options.dart';
import 'presentation/screens/auth_screens/auth_screen.dart';
import 'presentation/widgets/auth_web_wedgets/auth_web_screen.dart';

import 'localnotification.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();
  print('📱 Firebase Messaging Token: $token');

  if (!kIsWeb) {
    await LocalNotification.init();
    LocalNotification.ensureConnected();
  }

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => UserProfileBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        home: kIsWeb ? const AuthWebScreen() : const AuthScreen(),
      ),
    );
  }
}
