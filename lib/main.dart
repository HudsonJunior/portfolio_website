import 'package:firebase_analytics_web/firebase_analytics_web.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/features/core/firebase_initializer.dart';
import 'package:portfolio_website/features/core/presentation/cubits/control_page_cubit.dart';
import 'package:portfolio_website/features/core/router/app_router.dart';
import 'package:portfolio_website/firebase_options.dart';
import 'package:portfolio_website/resources/theme.dart';

void main() {
  usePathUrlStrategy();
  // Fonts are bundled under google_fonts/ — avoid runtime HTTP fetches that
  // crash the app when fonts.gstatic.com is unreachable.
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
      child: MaterialApp.router(
        title: 'Hudson Proença — Mobile & AI Applied Engineer',
        debugShowCheckedModeBanner: false,
        theme: PortfolioTheme.themeData,
        routerConfig: appRouter,
      ),
    );
  }
}
