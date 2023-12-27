import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youappflutter/bloc/auth/auth_bloc.dart';
import 'package:youappflutter/constants/string_constant.dart';
import 'package:youappflutter/init/cache/auth_cache_manager.dart';
import 'package:youappflutter/init/network/dio_manager.dart';
import 'package:youappflutter/services/auth_service.dart';
import 'package:youappflutter/views/splash/splash_view.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(
        AuthService(DioManager.instance),
        AuthCacheManager(),
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appName,
      home: const SplashView(),

      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
        ),
        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
