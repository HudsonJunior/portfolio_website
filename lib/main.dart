import 'package:firebase_analytics_web/firebase_analytics_web.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/core/firebase_initializer.dart';
import 'package:portfolio_website/features/core/presentation/cubits/control_page_cubit.dart';
import 'package:portfolio_website/features/splash/presentation/pages/splash_page.dart';
import 'package:portfolio_website/firebase_options.dart';
import 'package:portfolio_website/resources/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  void initializeFirebase() async {
    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAnalyticsWeb(app: app).logEvent(name: 'New access!');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ControlPageCubit>(
          create: (_) => ControlPageCubit(),
        ),
        BlocProvider<FirebaseInitializerCubit>(
          create: (_) => FirebaseInitializerCubit()..initializeApp(),
        ),
      ],
      child: MaterialApp(
        title: 'Hudson Portfolio',
        debugShowCheckedModeBanner: false,
        theme: PortfolioTheme.themeData,
        home: const SplashPage(),
      ),
    );
  }
}
