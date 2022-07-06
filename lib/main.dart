import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_website/features/core/presentation/cubits/control_page_cubit.dart';
import 'package:portfolio_website/features/splash/presentation/pages/splash_page.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ControlPageCubit>(
          create: (_) => ControlPageCubit(),
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
