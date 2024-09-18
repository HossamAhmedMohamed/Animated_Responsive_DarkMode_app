// ignore_for_file: prefer_const_constructors

import 'package:animation_splash_login/logic/theme_cubit/cubit/theme_cubit.dart';
import 'package:animation_splash_login/presentation/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => ThemeCubit()..setInitialTheme(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Animation App',
            theme: state.themeData,
            home: Splash());
      },
    );
  }
}
