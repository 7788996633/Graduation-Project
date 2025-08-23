import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import 'blocs/my_bloc_observere.dart';
import 'blocs/user_bloc/user_bloc.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'blocs/user_profile_bloc/user_profile_bloc.dart';
import 'data/services/notifications_services.dart';

import 'presentation/screens/auth_screens/auth_screen.dart';
import 'presentation/widgets/auth_web_wedgets/auth_web_screen.dart';

// /// معالجة رسائل الخلفية (Android / iOS)
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   // هنا ممكن تضيف منطق لمعالجة الإشعار
//   print("Handling a background message: ${message.messageId}");
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  //
  // // تهيئة Firebase
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  //
  // // تهيئة إشعارات Firebase Messaging
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // تهيئة الإشعارات المحلية
 // await NotificationsServices().initNotifications();

  // تهيئة EasyLocalization
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(),
        ),
        BlocProvider(
          create: (_) => UserBloc(),
        ),
        BlocProvider(
          create: (_) => UserProfileBloc(),
        ),
        BlocProvider(
          create: (_) => LawyerProfileBloc(),
        ),
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
